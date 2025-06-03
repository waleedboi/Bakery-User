import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:completefoodorderingappui/models/bakery_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BakeryListItem extends StatefulWidget {
  final BakeryModel bakery;
  final VoidCallback onTap;

  const BakeryListItem({
    Key? key,
    required this.bakery,
    required this.onTap,
  }) : super(key: key);

  @override
  State<BakeryListItem> createState() => _BakeryListItemState();
}

class _BakeryListItemState extends State<BakeryListItem> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    checkIfFavorite();
  }

  Future<void> checkIfFavorite() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('favorites')
          .doc(widget.bakery.id)
          .get();

      setState(() {
        isFavorite = doc.exists;
      });
    }
  }

  Future<void> toggleFavorite() async {
    final user = FirebaseAuth.instance.currentUser;
    final favRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('favorites')
        .doc(widget.bakery.id);

    if (isFavorite) {
      await favRef.delete();
    } else {
      await favRef.set(widget.bakery.toJson());
    }

    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: EdgeInsets.only(left: 23.w, right: 23.w, bottom: 15.h,top: 20),
        child: Card(
          elevation: 0,
          margin: EdgeInsets.zero,
          child: Container(
            height: 237.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(11.r),
            ),
            child: Column(
              children: [
                _buildImageSection(),
                _buildDetailsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
  return Stack(
    children: [
      // Image background
      Container(
        height: 157.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(11.r),
            topRight: Radius.circular(11.r),
          ),
          image: DecorationImage(
            image: widget.bakery.listofimages.isNotEmpty
                ? NetworkImage(widget.bakery.listofimages[0])
                : const AssetImage("images/item.png") as ImageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),

      // Gradient overlay
      Container(
        height: 157.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(11.r),
            topRight: Radius.circular(11.r),
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.4),
            ],
          ),
        ),
      ),

      // Foreground content
      Container(
        height: 157.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: toggleFavorite,
                  child: Container(
                    height: 35.h,
                    width: 35.w,
                    decoration: BoxDecoration(
                      color: const Color(0xff383736).withOpacity(0.8),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              widget.bakery.bakeryName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.17.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              widget.bakery.bakeryDescription,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.17.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    ],
  );
}


  Widget _buildDetailsSection() {
    return Expanded(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Image.asset("images/2xtime.png", height: 22.h),
                SizedBox(width: 8.w),
                Text(
                  widget.bakery.bakeryTiming,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Container(
                  height: 24.67.h,
                  width: 54.83.w,
                  decoration: const BoxDecoration(
                    color: Color(0xffFFC107),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(image: AssetImage("images/Star 1.png")),
                      SizedBox(width: 5.w),
                      Text(
                        "${widget.bakery.bakeryReview}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.21.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Image.asset("images/loc2x.png", height: 22.h),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    widget.bakery.bakeryLocation,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}