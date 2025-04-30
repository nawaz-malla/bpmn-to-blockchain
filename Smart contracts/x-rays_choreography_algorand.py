from pyteal import *
from beaker import *


class XRayChoreographyState:
    e0 = GlobalStateValue(stack_type=TealType.uint64, default=Int(1))
    e1 = GlobalStateValue(stack_type=TealType.uint64, default=Int(0))
    e2 = GlobalStateValue(stack_type=TealType.uint64, default=Int(0))
    e3 = GlobalStateValue(stack_type=TealType.uint64, default=Int(0))
    e4 = GlobalStateValue(stack_type=TealType.uint64, default=Int(0))
    e5 = GlobalStateValue(stack_type=TealType.uint64, default=Int(0))
    e6 = GlobalStateValue(stack_type=TealType.uint64, default=Int(0))
    e7 = GlobalStateValue(stack_type=TealType.uint64, default=Int(0))
    e8 = GlobalStateValue(stack_type=TealType.uint64, default=Int(0))
    e9 = GlobalStateValue(stack_type=TealType.uint64, default=Int(0))
    e10 = GlobalStateValue(stack_type=TealType.uint64, default=Int(0))
    e11 = GlobalStateValue(stack_type=TealType.uint64, default=Int(0))
    e12 = GlobalStateValue(stack_type=TealType.uint64, default=Int(0))
    e13 = GlobalStateValue(stack_type=TealType.uint64, default=Int(0))
    e14 = GlobalStateValue(stack_type=TealType.uint64, default=Int(0))
    e15 = GlobalStateValue(stack_type=TealType.uint64, default=Int(0))
    e16 = GlobalStateValue(stack_type=TealType.uint64, default=Int(0))
    e17 = GlobalStateValue(stack_type=TealType.uint64, default=Int(0))
    e18 = GlobalStateValue(stack_type=TealType.uint64, default=Int(0))
    e19 = GlobalStateValue(stack_type=TealType.uint64, default=Int(0))

    enabled_messages = GlobalStateValue(stack_type=TealType.uint64, default=Int(0))

    ward = Addr("GDMVSGQMZKUDMIJ54RCMBGSW7YK6N53QYBS74UC3MIGT7EBR4VKEUAOHIE")
    patient = Addr("RGKMCAKVBEPGKTJIMF4W7NIJIACKCL2XZGSRQXX3V4FXGDK6D2CXPZC5SM")
    radiology = Addr("D5NCMATCVMWGZ7S6VZZKRZJKRENF22L7FFGSKXHX2PDSDAR3G6C6N2VUJE")

    # Define state variables for various message statuses and payloads
    status_appointment = GlobalStateValue(stack_type=TealType.uint64, default=Int(0))
    payload_appointment = GlobalStateValue(stack_type=TealType.bytes, default=Bytes(""))
    status_request = GlobalStateValue(stack_type=TealType.uint64, default=Int(0))
    payload_request = GlobalStateValue(stack_type=TealType.bytes, default=Bytes(""))
    status_response = GlobalStateValue(stack_type=TealType.uint64, default=Int(0))
    payload_response_accepted = GlobalStateValue(stack_type=TealType.uint64, default=Int(0))
    payload_response_date = GlobalStateValue(stack_type=TealType.bytes, default=Bytes(""))
    status_registration = GlobalStateValue(stack_type=TealType.uint64, default=Int(0))
    payload_registration_date = GlobalStateValue(stack_type=TealType.bytes, default=Bytes(""))
    payload_registration_appointmentId = GlobalStateValue(stack_type=TealType.bytes, default=Bytes(""))
    status_certification = GlobalStateValue(stack_type=TealType.uint64, default=Int(0))
    payload_certification = GlobalStateValue(stack_type=TealType.bytes, default=Bytes(""))
    status_temperature = GlobalStateValue(stack_type=TealType.uint64, default=Int(0))
    payload_temperature = GlobalStateValue(stack_type=TealType.bytes, default=Bytes(""))
    status_checkin = GlobalStateValue(stack_type=TealType.uint64, default=Int(0))
    payload_checkin = GlobalStateValue(stack_type=TealType.bytes, default=Bytes(""))
    status_confirmation = GlobalStateValue(stack_type=TealType.uint64, default=Int(0))
    payload_confirmation = GlobalStateValue(stack_type=TealType.uint64, default=Int(0))
    status_analysis = GlobalStateValue(stack_type=TealType.uint64, default=Int(0))
    payload_analysis = GlobalStateValue(stack_type=TealType.bytes, default=Bytes(""))
    status_report = GlobalStateValue(stack_type=TealType.uint64, default=Int(0))
    payload_report = GlobalStateValue(stack_type=TealType.bytes, default=Bytes(""))


# Instantiate the application with the state
app = Application("XRayChoreography", state=XRayChoreographyState())


@app.create(bare=True)
def create() -> Expr:
    return app.initialize_global_state()


# Define the subroutines
@Subroutine(TealType.uint64)
def start1():
    return Seq(
        If(app.state.e0.get() > Int(0)).Then(
            Seq(
                app.state.e0.set(Int(0)),
                app.state.e1.set(app.state.e1.get() + Int(1)),
                Int(1)
            )
        ).Else(
            Int(0)
        )
    )


@Subroutine(TealType.uint64)
def take_appointment():
    return Seq(
        If(app.state.e1.get() > Int(0)).Then(
            Seq(
                App.globalPut(Bytes("Message"), Bytes("Patient 'radiology': appointment")),
                app.state.e1.set(app.state.e1.get() - Int(1)),
                app.state.status_appointment.set(Int(1)),
                app.state.enabled_messages.set(app.state.enabled_messages.get() + Int(1)),
                Int(1)
            )
        ).Else(
            Int(0)
        )
    )


@app.external
def appointment(payload: abi.String):
    return Seq(
        If(app.state.status_appointment.get() == Int(1)).Then(
            Seq(
                app.state.payload_appointment.set(payload.get()),
                app.state.status_appointment.set(Int(0)),
                app.state.enabled_messages.set(app.state.enabled_messages.get() - Int(1)),
                app.state.e2.set(app.state.e2.get() + Int(1)),
                execute()
            )
        ).Else(
            Reject()
        )
    )


@Subroutine(TealType.uint64)
def xor1():
    return Seq(
        If(app.state.e2.get() > Int(0)).Then(
            Seq(
                app.state.e2.set(app.state.e2.get() - Int(1)),
                app.state.e3.set(app.state.e3.get() + Int(1)),
                Int(1)
            )
        ).ElseIf(app.state.e6.get() > Int(0)).Then(
            Seq(
                app.state.e6.set(app.state.e6.get() - Int(1)),
                app.state.e3.set(app.state.e3.get() + Int(1)),
                Int(1)
            )
        ).Else(
            Int(0)
        )
    )


@Subroutine(TealType.uint64)
def check_availability():
    return Seq(
        If(app.state.e3.get() > Int(0)).Then(
            Seq(
                App.globalPut(Bytes("Message"), Bytes("radiology 'ward': request")),
                app.state.e3.set(app.state.e3.get() - Int(1)),
                app.state.status_request.set(Int(1)),
                app.state.enabled_messages.set(app.state.enabled_messages.get() + Int(1)),
                Int(1)
            )
        ).Else(
            Int(0)
        )
    )


@app.external
def request(payload: abi.String):
    return Seq(
        If(app.state.status_request.get() == Int(1)).Then(
            Seq(
                app.state.payload_request.set(payload.get()),
                app.state.status_request.set(Int(0)),
                app.state.enabled_messages.set(app.state.enabled_messages.get() - Int(1)),
                app.state.e4.set(app.state.e4.get() + Int(1)),
                execute()
            )
        ).Else(
            Reject()
        )
    )


@Subroutine(TealType.uint64)
def check_availability_resp():
    return Seq(
        If(app.state.e4.get() > Int(0)).Then(
            Seq(
                App.globalPut(Bytes("Execution"), Bytes("ward, radiology ,response")),
                app.state.e4.set(app.state.e4.get() - Int(1)),
                app.state.status_response.set(Int(1)),
                app.state.enabled_messages.set(app.state.enabled_messages.get() + Int(1)),
                Int(1)
            )
        ).Else(
            Int(0)
        )
    )


@app.external
def response(payload: abi.Uint64, payload1: abi.String):
    return Seq(
        If(app.state.status_response.get() == Int(1)).Then(
            Seq(
                app.state.payload_response_accepted.set(payload.get()),
                app.state.payload_response_date.set(payload1.get()),
                app.state.status_response.set(Int(0)),
                app.state.enabled_messages.set(app.state.enabled_messages.get() - Int(1)),
                app.state.e5.set(app.state.e5.get() + Int(1)),
                execute()
            )
        ).Else(
            Reject()
        )
    )


@Subroutine(TealType.uint64)
def execute():
    return Seq(
        start1(),
        take_appointment(),
        xor1(),
        check_availability(),
        check_availability_resp()
    )


if __name__ == "__main__":
    app.build().export("./artifacts")
