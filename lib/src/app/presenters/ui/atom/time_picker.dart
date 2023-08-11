import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:uitcc/src/app/domain/entities/equipment_model.dart';

class TimePicker extends StatefulWidget {
  final EquipmentModel equiModel;
  const TimePicker({
    super.key,
    required this.equiModel,
  });

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  bool isTimeValid = true;

  checkTimeIsValid() {
    if (widget.equiModel.time.hour == 0 && widget.equiModel.time.minute == 0) {
      isTimeValid = false;
    } else {
      isTimeValid = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TimePickerSpinner(
          is24HourMode: true,
          normalTextStyle: const TextStyle(
            fontSize: 19,
            color: Colors.grey,
          ),
          highlightedTextStyle: const TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
          spacing: 0,
          itemHeight: 30,
          alignment: Alignment.center,
          time: widget.equiModel.time,
          isForce2Digits: true,
          onTimeChange: (time) {
            setState(() {
              widget.equiModel.time = time;
              checkTimeIsValid();
            });
          },
        ),
        Visibility(
          visible: !isTimeValid,
          replacement: const SizedBox.shrink(),
          child: Container(
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Theme.of(context).colorScheme.error),
              ),
              color: Theme.of(context).colorScheme.background,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Text(
              'Tempo não pode ser 0',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ),
      ],
    );
  }
}
