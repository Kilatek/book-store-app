import 'package:book_store/core/dimens/dimens.dart';
import 'package:book_store/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RoundDropDown extends StatelessWidget {
  final String value;
  final String hitText;
  final String icon;
  final Widget? rigtIcon;
  final EdgeInsets? margin;
  final void Function((String, int))? onChanged;
  final List<String> items;
  const RoundDropDown({
    super.key,
    required this.hitText,
    required this.icon,
    required this.value,
    required this.items,
    this.margin,
    this.rigtIcon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin,
        decoration: BoxDecoration(
          color: AppColors.lightGray,
          borderRadius: BorderRadius.circular(
            Dimens.d15,
          ),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 14,
            ),
            Container(
              alignment: Alignment.center,
              width: Dimens.d20,
              height: Dimens.d20,
              child: Image.asset(
                icon,
                width: Dimens.d20,
                height: Dimens.d20,
                fit: BoxFit.contain,
                color: AppColors.gray,
              ),
            ),
            const SizedBox(
              width: 14,
            ),
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  items: items
                      .map(
                        (name) => DropdownMenuItem(
                          value: name,
                          child: Text(
                            name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      onChanged?.call((value, items.indexOf(value)));
                    }
                  },
                  icon: rigtIcon ??
                      Icon(
                        Icons.expand_more,
                        color: AppColors.gray,
                      ),
                  hint: Text(
                    hitText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.gray,
                      fontSize: 12,
                    ),
                  ),
                  value: value,
                ),
              ),
            ),
            const SizedBox(
              width: 14,
            ),
          ],
        ));
  }
}
