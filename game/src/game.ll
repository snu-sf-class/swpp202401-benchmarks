; ModuleID = '.tmp/a.ll'
source_filename = "game/src/game.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@R = external global i64, align 8
@C = external global i64, align 8
@Yroot = external global ptr, align 8
@Q = external global i64, align 8
@V = external global i64, align 8
@P = external global i64, align 8
@U = external global i64, align 8
@K = external global i64, align 8

; Function Attrs: nounwind uwtable
define dso_local i64 @gcd2(i64 noundef %X, i64 noundef %Y) #0 {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %Y.addr.0 = phi i64 [ %Y, %entry ], [ %rem, %while.body ]
  %X.addr.0 = phi i64 [ %X, %entry ], [ %Y.addr.0, %while.body ]
  %cmp = icmp ne i64 %X.addr.0, %Y.addr.0
  br i1 %cmp, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %while.cond
  %cmp1 = icmp ne i64 %Y.addr.0, 0
  br label %land.end

land.end:                                         ; preds = %land.rhs, %while.cond
  %0 = phi i1 [ false, %while.cond ], [ %cmp1, %land.rhs ]
  br i1 %0, label %while.body, label %while.end

while.body:                                       ; preds = %land.end
  %rem = urem i64 %X.addr.0, %Y.addr.0
  br label %while.cond, !llvm.loop !5

while.end:                                        ; preds = %land.end
  ret i64 %X.addr.0
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nounwind uwtable
define dso_local void @init(i64 noundef %R_, i64 noundef %C_) #0 {
entry:
  store i64 1, ptr @R, align 8
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i64, ptr @R, align 8
  %cmp = icmp ult i64 %0, %R_
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %1 = load i64, ptr @R, align 8
  %shl = shl i64 %1, 1
  store i64 %shl, ptr @R, align 8
  br label %for.cond, !llvm.loop !8

for.end:                                          ; preds = %for.cond
  store i64 1, ptr @C, align 8
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc4, %for.end
  %2 = load i64, ptr @C, align 8
  %cmp2 = icmp ult i64 %2, %C_
  br i1 %cmp2, label %for.body3, label %for.end6

for.body3:                                        ; preds = %for.cond1
  br label %for.inc4

for.inc4:                                         ; preds = %for.body3
  %3 = load i64, ptr @C, align 8
  %shl5 = shl i64 %3, 1
  store i64 %shl5, ptr @C, align 8
  br label %for.cond1, !llvm.loop !9

for.end6:                                         ; preds = %for.cond1
  %call = call noalias ptr @malloc(i64 noundef 24) #4
  store ptr %call, ptr @Yroot, align 8
  %4 = load ptr, ptr @Yroot, align 8
  store ptr null, ptr %4, align 8
  %5 = load ptr, ptr @Yroot, align 8
  %add.ptr = getelementptr inbounds ptr, ptr %5, i64 1
  store ptr null, ptr %add.ptr, align 8
  %6 = load ptr, ptr @Yroot, align 8
  %add.ptr7 = getelementptr inbounds ptr, ptr %6, i64 2
  store ptr null, ptr %add.ptr7, align 8
  ret void
}

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #2

; Function Attrs: nounwind uwtable
define dso_local i64 @Xcalculate(ptr noundef %now) #0 {
entry:
  %0 = load i64, ptr @Q, align 8
  %add.ptr = getelementptr inbounds i64, ptr %now, i64 2
  %1 = load i64, ptr %add.ptr, align 8
  %cmp = icmp ule i64 %0, %1
  br i1 %cmp, label %land.lhs.true, label %if.else

land.lhs.true:                                    ; preds = %entry
  %add.ptr1 = getelementptr inbounds i64, ptr %now, i64 3
  %2 = load i64, ptr %add.ptr1, align 8
  %3 = load i64, ptr @V, align 8
  %cmp2 = icmp ule i64 %2, %3
  br i1 %cmp2, label %if.then, label %if.else

if.then:                                          ; preds = %land.lhs.true
  %add.ptr3 = getelementptr inbounds i64, ptr %now, i64 4
  %4 = load i64, ptr %add.ptr3, align 8
  br label %cleanup

if.else:                                          ; preds = %land.lhs.true, %entry
  %5 = load ptr, ptr %now, align 8
  %cmp4 = icmp ne ptr %5, null
  br i1 %cmp4, label %land.lhs.true5, label %if.end

land.lhs.true5:                                   ; preds = %if.else
  %6 = load i64, ptr @Q, align 8
  %7 = load ptr, ptr %now, align 8
  %add.ptr6 = getelementptr inbounds i64, ptr %7, i64 3
  %8 = load i64, ptr %add.ptr6, align 8
  %cmp7 = icmp ule i64 %6, %8
  br i1 %cmp7, label %land.lhs.true8, label %if.end

land.lhs.true8:                                   ; preds = %land.lhs.true5
  %9 = load ptr, ptr %now, align 8
  %add.ptr9 = getelementptr inbounds i64, ptr %9, i64 2
  %10 = load i64, ptr %add.ptr9, align 8
  %11 = load i64, ptr @V, align 8
  %cmp10 = icmp ule i64 %10, %11
  br i1 %cmp10, label %if.then11, label %if.end

if.then11:                                        ; preds = %land.lhs.true8
  %12 = load ptr, ptr %now, align 8
  %call = call i64 @Xcalculate(ptr noundef %12)
  br label %if.end

if.end:                                           ; preds = %if.then11, %land.lhs.true8, %land.lhs.true5, %if.else
  %value.0 = phi i64 [ %call, %if.then11 ], [ 0, %land.lhs.true8 ], [ 0, %land.lhs.true5 ], [ 0, %if.else ]
  %add.ptr12 = getelementptr inbounds ptr, ptr %now, i64 1
  %13 = load ptr, ptr %add.ptr12, align 8
  %cmp13 = icmp ne ptr %13, null
  br i1 %cmp13, label %land.lhs.true14, label %if.end26

land.lhs.true14:                                  ; preds = %if.end
  %14 = load i64, ptr @Q, align 8
  %add.ptr15 = getelementptr inbounds ptr, ptr %now, i64 1
  %15 = load ptr, ptr %add.ptr15, align 8
  %add.ptr16 = getelementptr inbounds i64, ptr %15, i64 3
  %16 = load i64, ptr %add.ptr16, align 8
  %cmp17 = icmp ule i64 %14, %16
  br i1 %cmp17, label %land.lhs.true18, label %if.end26

land.lhs.true18:                                  ; preds = %land.lhs.true14
  %add.ptr19 = getelementptr inbounds ptr, ptr %now, i64 1
  %17 = load ptr, ptr %add.ptr19, align 8
  %add.ptr20 = getelementptr inbounds i64, ptr %17, i64 2
  %18 = load i64, ptr %add.ptr20, align 8
  %19 = load i64, ptr @V, align 8
  %cmp21 = icmp ule i64 %18, %19
  br i1 %cmp21, label %if.then22, label %if.end26

if.then22:                                        ; preds = %land.lhs.true18
  %add.ptr23 = getelementptr inbounds ptr, ptr %now, i64 1
  %20 = load ptr, ptr %add.ptr23, align 8
  %call24 = call i64 @Xcalculate(ptr noundef %20)
  %call25 = call i64 @gcd2(i64 noundef %value.0, i64 noundef %call24)
  br label %if.end26

if.end26:                                         ; preds = %if.then22, %land.lhs.true18, %land.lhs.true14, %if.end
  %value.1 = phi i64 [ %call25, %if.then22 ], [ %value.0, %land.lhs.true18 ], [ %value.0, %land.lhs.true14 ], [ %value.0, %if.end ]
  br label %cleanup

cleanup:                                          ; preds = %if.end26, %if.then
  %retval.0 = phi i64 [ %4, %if.then ], [ %value.1, %if.end26 ]
  ret i64 %retval.0
}

; Function Attrs: nounwind uwtable
define dso_local i64 @Ycalculate(i64 noundef %l, i64 noundef %r, ptr noundef %now) #0 {
entry:
  %add = add i64 %l, %r
  %shr = lshr i64 %add, 1
  %0 = load i64, ptr @P, align 8
  %cmp = icmp ule i64 %0, %l
  br i1 %cmp, label %land.lhs.true, label %if.else

land.lhs.true:                                    ; preds = %entry
  %1 = load i64, ptr @U, align 8
  %cmp1 = icmp ule i64 %r, %1
  br i1 %cmp1, label %if.then, label %if.else

if.then:                                          ; preds = %land.lhs.true
  %add.ptr = getelementptr inbounds ptr, ptr %now, i64 2
  %2 = load ptr, ptr %add.ptr, align 8
  %cmp2 = icmp ne ptr %2, null
  br i1 %cmp2, label %if.then3, label %if.end

if.then3:                                         ; preds = %if.then
  %add.ptr4 = getelementptr inbounds ptr, ptr %now, i64 2
  %3 = load ptr, ptr %add.ptr4, align 8
  %call = call i64 @Xcalculate(ptr noundef %3)
  br label %if.end

if.end:                                           ; preds = %if.then3, %if.then
  %value.0 = phi i64 [ %call, %if.then3 ], [ 0, %if.then ]
  br label %cleanup

if.else:                                          ; preds = %land.lhs.true, %entry
  %4 = load i64, ptr @P, align 8
  %cmp5 = icmp ule i64 %4, %shr
  br i1 %cmp5, label %land.lhs.true6, label %if.end10

land.lhs.true6:                                   ; preds = %if.else
  %5 = load ptr, ptr %now, align 8
  %cmp7 = icmp ne ptr %5, null
  br i1 %cmp7, label %if.then8, label %if.end10

if.then8:                                         ; preds = %land.lhs.true6
  %6 = load ptr, ptr %now, align 8
  %call9 = call i64 @Ycalculate(i64 noundef %l, i64 noundef %shr, ptr noundef %6)
  br label %if.end10

if.end10:                                         ; preds = %if.then8, %land.lhs.true6, %if.else
  %value.1 = phi i64 [ %call9, %if.then8 ], [ 0, %land.lhs.true6 ], [ 0, %if.else ]
  %add11 = add i64 %shr, 1
  %7 = load i64, ptr @U, align 8
  %cmp12 = icmp ule i64 %add11, %7
  br i1 %cmp12, label %land.lhs.true13, label %if.end21

land.lhs.true13:                                  ; preds = %if.end10
  %add.ptr14 = getelementptr inbounds ptr, ptr %now, i64 1
  %8 = load ptr, ptr %add.ptr14, align 8
  %cmp15 = icmp ne ptr %8, null
  br i1 %cmp15, label %if.then16, label %if.end21

if.then16:                                        ; preds = %land.lhs.true13
  %add17 = add i64 %shr, 1
  %add.ptr18 = getelementptr inbounds ptr, ptr %now, i64 1
  %9 = load ptr, ptr %add.ptr18, align 8
  %call19 = call i64 @Ycalculate(i64 noundef %add17, i64 noundef %r, ptr noundef %9)
  %call20 = call i64 @gcd2(i64 noundef %value.1, i64 noundef %call19)
  br label %if.end21

if.end21:                                         ; preds = %if.then16, %land.lhs.true13, %if.end10
  %value.2 = phi i64 [ %call20, %if.then16 ], [ %value.1, %land.lhs.true13 ], [ %value.1, %if.end10 ]
  br label %cleanup

cleanup:                                          ; preds = %if.end21, %if.end
  %retval.0 = phi i64 [ %value.0, %if.end ], [ %value.2, %if.end21 ]
  ret i64 %retval.0
}

; Function Attrs: nounwind uwtable
define dso_local void @Xupdate(ptr noundef %now) #0 {
entry:
  %add.ptr = getelementptr inbounds i64, ptr %now, i64 2
  %0 = load i64, ptr %add.ptr, align 8
  %add.ptr1 = getelementptr inbounds i64, ptr %now, i64 3
  %1 = load i64, ptr %add.ptr1, align 8
  %add = add i64 %0, %1
  %shr = lshr i64 %add, 1
  %add.ptr2 = getelementptr inbounds i64, ptr %now, i64 2
  %2 = load i64, ptr %add.ptr2, align 8
  %3 = load i64, ptr @Q, align 8
  %cmp = icmp eq i64 %2, %3
  br i1 %cmp, label %land.lhs.true, label %if.else

land.lhs.true:                                    ; preds = %entry
  %4 = load i64, ptr @Q, align 8
  %add.ptr3 = getelementptr inbounds i64, ptr %now, i64 3
  %5 = load i64, ptr %add.ptr3, align 8
  %cmp4 = icmp eq i64 %4, %5
  br i1 %cmp4, label %if.then, label %if.else

if.then:                                          ; preds = %land.lhs.true
  %6 = load i64, ptr @K, align 8
  %add.ptr5 = getelementptr inbounds i64, ptr %now, i64 4
  store i64 %6, ptr %add.ptr5, align 8
  br label %if.end166

if.else:                                          ; preds = %land.lhs.true, %entry
  %7 = load i64, ptr @Q, align 8
  %cmp6 = icmp ule i64 %7, %shr
  br i1 %cmp6, label %if.then7, label %if.else59

if.then7:                                         ; preds = %if.else
  %8 = load ptr, ptr %now, align 8
  %cmp8 = icmp eq ptr %8, null
  br i1 %cmp8, label %if.then9, label %if.end

if.then9:                                         ; preds = %if.then7
  %call = call noalias ptr @malloc(i64 noundef 40) #4
  store ptr %call, ptr %now, align 8
  %9 = load ptr, ptr %now, align 8
  store ptr null, ptr %9, align 8
  %10 = load ptr, ptr %now, align 8
  %add.ptr10 = getelementptr inbounds ptr, ptr %10, i64 1
  store ptr null, ptr %add.ptr10, align 8
  %11 = load i64, ptr @Q, align 8
  %12 = load ptr, ptr %now, align 8
  %add.ptr11 = getelementptr inbounds i64, ptr %12, i64 2
  store i64 %11, ptr %add.ptr11, align 8
  %13 = load i64, ptr @Q, align 8
  %14 = load ptr, ptr %now, align 8
  %add.ptr12 = getelementptr inbounds i64, ptr %14, i64 3
  store i64 %13, ptr %add.ptr12, align 8
  %15 = load ptr, ptr %now, align 8
  %add.ptr13 = getelementptr inbounds i64, ptr %15, i64 4
  store i64 0, ptr %add.ptr13, align 8
  br label %if.end

if.end:                                           ; preds = %if.then9, %if.then7
  %16 = load i64, ptr @Q, align 8
  %17 = load ptr, ptr %now, align 8
  %add.ptr14 = getelementptr inbounds i64, ptr %17, i64 2
  %18 = load i64, ptr %add.ptr14, align 8
  %cmp15 = icmp ult i64 %16, %18
  br i1 %cmp15, label %if.then18, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %if.end
  %19 = load ptr, ptr %now, align 8
  %add.ptr16 = getelementptr inbounds i64, ptr %19, i64 3
  %20 = load i64, ptr %add.ptr16, align 8
  %21 = load i64, ptr @Q, align 8
  %cmp17 = icmp ult i64 %20, %21
  br i1 %cmp17, label %if.then18, label %if.end58

if.then18:                                        ; preds = %lor.lhs.false, %if.end
  %22 = load ptr, ptr %now, align 8
  %call19 = call noalias ptr @malloc(i64 noundef 40) #4
  store ptr %call19, ptr %now, align 8
  %23 = load ptr, ptr %now, align 8
  store ptr null, ptr %23, align 8
  %24 = load ptr, ptr %now, align 8
  %add.ptr20 = getelementptr inbounds ptr, ptr %24, i64 1
  store ptr null, ptr %add.ptr20, align 8
  %add.ptr21 = getelementptr inbounds i64, ptr %now, i64 2
  %25 = load i64, ptr %add.ptr21, align 8
  %26 = load ptr, ptr %now, align 8
  %add.ptr22 = getelementptr inbounds i64, ptr %26, i64 2
  store i64 %25, ptr %add.ptr22, align 8
  %27 = load ptr, ptr %now, align 8
  %add.ptr23 = getelementptr inbounds i64, ptr %27, i64 3
  store i64 %shr, ptr %add.ptr23, align 8
  %28 = load ptr, ptr %now, align 8
  %add.ptr24 = getelementptr inbounds i64, ptr %28, i64 4
  store i64 0, ptr %add.ptr24, align 8
  %29 = load i64, ptr @Q, align 8
  %add.ptr25 = getelementptr inbounds i64, ptr %22, i64 2
  %30 = load i64, ptr %add.ptr25, align 8
  %cmp26 = icmp ult i64 %29, %30
  br i1 %cmp26, label %if.then27, label %if.else29

if.then27:                                        ; preds = %if.then18
  %31 = load ptr, ptr %now, align 8
  %add.ptr28 = getelementptr inbounds ptr, ptr %31, i64 1
  store ptr %22, ptr %add.ptr28, align 8
  br label %if.end30

if.else29:                                        ; preds = %if.then18
  %32 = load ptr, ptr %now, align 8
  store ptr %22, ptr %32, align 8
  br label %if.end30

if.end30:                                         ; preds = %if.else29, %if.then27
  br label %while.cond

while.cond:                                       ; preds = %if.end57, %if.end30
  br label %while.body

while.body:                                       ; preds = %while.cond
  %33 = load ptr, ptr %now, align 8
  %add.ptr31 = getelementptr inbounds i64, ptr %33, i64 3
  %34 = load i64, ptr %add.ptr31, align 8
  %35 = load ptr, ptr %now, align 8
  %add.ptr32 = getelementptr inbounds i64, ptr %35, i64 2
  %36 = load i64, ptr %add.ptr32, align 8
  %sub = sub i64 %34, %36
  %add33 = add i64 %sub, 1
  %shr34 = lshr i64 %add33, 1
  %37 = load ptr, ptr %now, align 8
  %add.ptr35 = getelementptr inbounds i64, ptr %37, i64 2
  %38 = load i64, ptr %add.ptr35, align 8
  %39 = load ptr, ptr %now, align 8
  %add.ptr36 = getelementptr inbounds i64, ptr %39, i64 3
  %40 = load i64, ptr %add.ptr36, align 8
  %add37 = add i64 %38, %40
  %shr38 = lshr i64 %add37, 1
  %41 = load i64, ptr @Q, align 8
  %and = and i64 %41, %shr34
  %tobool = icmp ne i64 %and, 0
  br i1 %tobool, label %if.else45, label %land.lhs.true39

land.lhs.true39:                                  ; preds = %while.body
  %add.ptr40 = getelementptr inbounds i64, ptr %22, i64 2
  %42 = load i64, ptr %add.ptr40, align 8
  %and41 = and i64 %42, %shr34
  %tobool42 = icmp ne i64 %and41, 0
  br i1 %tobool42, label %if.else45, label %if.then43

if.then43:                                        ; preds = %land.lhs.true39
  %43 = load ptr, ptr %now, align 8
  %add.ptr44 = getelementptr inbounds i64, ptr %43, i64 3
  store i64 %shr38, ptr %add.ptr44, align 8
  br label %if.end57

if.else45:                                        ; preds = %land.lhs.true39, %while.body
  %44 = load i64, ptr @Q, align 8
  %and46 = and i64 %44, %shr34
  %tobool47 = icmp ne i64 %and46, 0
  br i1 %tobool47, label %land.lhs.true48, label %if.else55

land.lhs.true48:                                  ; preds = %if.else45
  %add.ptr49 = getelementptr inbounds i64, ptr %22, i64 2
  %45 = load i64, ptr %add.ptr49, align 8
  %and50 = and i64 %45, %shr34
  %tobool51 = icmp ne i64 %and50, 0
  br i1 %tobool51, label %if.then52, label %if.else55

if.then52:                                        ; preds = %land.lhs.true48
  %add53 = add i64 %shr38, 1
  %46 = load ptr, ptr %now, align 8
  %add.ptr54 = getelementptr inbounds i64, ptr %46, i64 2
  store i64 %add53, ptr %add.ptr54, align 8
  br label %if.end56

if.else55:                                        ; preds = %land.lhs.true48, %if.else45
  br label %while.end

if.end56:                                         ; preds = %if.then52
  br label %if.end57

if.end57:                                         ; preds = %if.end56, %if.then43
  br label %while.cond, !llvm.loop !10

while.end:                                        ; preds = %if.else55
  br label %if.end58

if.end58:                                         ; preds = %while.end, %lor.lhs.false
  %47 = load ptr, ptr %now, align 8
  call void @Xupdate(ptr noundef %47)
  br label %if.end146

if.else59:                                        ; preds = %if.else
  %add.ptr60 = getelementptr inbounds ptr, ptr %now, i64 1
  %48 = load ptr, ptr %add.ptr60, align 8
  %cmp61 = icmp eq ptr %48, null
  br i1 %cmp61, label %if.then62, label %if.end74

if.then62:                                        ; preds = %if.else59
  %call63 = call noalias ptr @malloc(i64 noundef 40) #4
  %add.ptr64 = getelementptr inbounds ptr, ptr %now, i64 1
  store ptr %call63, ptr %add.ptr64, align 8
  %add.ptr65 = getelementptr inbounds ptr, ptr %now, i64 1
  %49 = load ptr, ptr %add.ptr65, align 8
  store ptr null, ptr %49, align 8
  %add.ptr66 = getelementptr inbounds ptr, ptr %now, i64 1
  %50 = load ptr, ptr %add.ptr66, align 8
  %add.ptr67 = getelementptr inbounds ptr, ptr %50, i64 1
  store ptr null, ptr %add.ptr67, align 8
  %51 = load i64, ptr @Q, align 8
  %add.ptr68 = getelementptr inbounds ptr, ptr %now, i64 1
  %52 = load ptr, ptr %add.ptr68, align 8
  %add.ptr69 = getelementptr inbounds i64, ptr %52, i64 2
  store i64 %51, ptr %add.ptr69, align 8
  %53 = load i64, ptr @Q, align 8
  %add.ptr70 = getelementptr inbounds ptr, ptr %now, i64 1
  %54 = load ptr, ptr %add.ptr70, align 8
  %add.ptr71 = getelementptr inbounds i64, ptr %54, i64 3
  store i64 %53, ptr %add.ptr71, align 8
  %add.ptr72 = getelementptr inbounds ptr, ptr %now, i64 1
  %55 = load ptr, ptr %add.ptr72, align 8
  %add.ptr73 = getelementptr inbounds i64, ptr %55, i64 4
  store i64 0, ptr %add.ptr73, align 8
  br label %if.end74

if.end74:                                         ; preds = %if.then62, %if.else59
  %56 = load i64, ptr @Q, align 8
  %add.ptr75 = getelementptr inbounds ptr, ptr %now, i64 1
  %57 = load ptr, ptr %add.ptr75, align 8
  %add.ptr76 = getelementptr inbounds i64, ptr %57, i64 2
  %58 = load i64, ptr %add.ptr76, align 8
  %cmp77 = icmp ult i64 %56, %58
  br i1 %cmp77, label %if.then82, label %lor.lhs.false78

lor.lhs.false78:                                  ; preds = %if.end74
  %add.ptr79 = getelementptr inbounds ptr, ptr %now, i64 1
  %59 = load ptr, ptr %add.ptr79, align 8
  %add.ptr80 = getelementptr inbounds i64, ptr %59, i64 3
  %60 = load i64, ptr %add.ptr80, align 8
  %61 = load i64, ptr @Q, align 8
  %cmp81 = icmp ult i64 %60, %61
  br i1 %cmp81, label %if.then82, label %if.end144

if.then82:                                        ; preds = %lor.lhs.false78, %if.end74
  %add.ptr83 = getelementptr inbounds ptr, ptr %now, i64 1
  %62 = load ptr, ptr %add.ptr83, align 8
  %call84 = call noalias ptr @malloc(i64 noundef 40) #4
  %add.ptr85 = getelementptr inbounds ptr, ptr %now, i64 1
  store ptr %call84, ptr %add.ptr85, align 8
  %add.ptr86 = getelementptr inbounds ptr, ptr %now, i64 1
  %63 = load ptr, ptr %add.ptr86, align 8
  store ptr null, ptr %63, align 8
  %add.ptr87 = getelementptr inbounds ptr, ptr %now, i64 1
  %64 = load ptr, ptr %add.ptr87, align 8
  %add.ptr88 = getelementptr inbounds ptr, ptr %64, i64 1
  store ptr null, ptr %add.ptr88, align 8
  %add89 = add i64 %shr, 1
  %add.ptr90 = getelementptr inbounds ptr, ptr %now, i64 1
  %65 = load ptr, ptr %add.ptr90, align 8
  %add.ptr91 = getelementptr inbounds i64, ptr %65, i64 2
  store i64 %add89, ptr %add.ptr91, align 8
  %add.ptr92 = getelementptr inbounds i64, ptr %now, i64 3
  %66 = load i64, ptr %add.ptr92, align 8
  %add.ptr93 = getelementptr inbounds ptr, ptr %now, i64 1
  %67 = load ptr, ptr %add.ptr93, align 8
  %add.ptr94 = getelementptr inbounds i64, ptr %67, i64 3
  store i64 %66, ptr %add.ptr94, align 8
  %add.ptr95 = getelementptr inbounds ptr, ptr %now, i64 1
  %68 = load ptr, ptr %add.ptr95, align 8
  %add.ptr96 = getelementptr inbounds i64, ptr %68, i64 4
  store i64 0, ptr %add.ptr96, align 8
  %69 = load i64, ptr @Q, align 8
  %add.ptr97 = getelementptr inbounds i64, ptr %62, i64 2
  %70 = load i64, ptr %add.ptr97, align 8
  %cmp98 = icmp ult i64 %69, %70
  br i1 %cmp98, label %if.then99, label %if.else102

if.then99:                                        ; preds = %if.then82
  %add.ptr100 = getelementptr inbounds ptr, ptr %now, i64 1
  %71 = load ptr, ptr %add.ptr100, align 8
  %add.ptr101 = getelementptr inbounds ptr, ptr %71, i64 1
  store ptr %62, ptr %add.ptr101, align 8
  br label %if.end104

if.else102:                                       ; preds = %if.then82
  %add.ptr103 = getelementptr inbounds ptr, ptr %now, i64 1
  %72 = load ptr, ptr %add.ptr103, align 8
  store ptr %62, ptr %72, align 8
  br label %if.end104

if.end104:                                        ; preds = %if.else102, %if.then99
  br label %while.cond105

while.cond105:                                    ; preds = %if.end142, %if.end104
  br label %while.body106

while.body106:                                    ; preds = %while.cond105
  %add.ptr107 = getelementptr inbounds ptr, ptr %now, i64 1
  %73 = load ptr, ptr %add.ptr107, align 8
  %add.ptr108 = getelementptr inbounds i64, ptr %73, i64 3
  %74 = load i64, ptr %add.ptr108, align 8
  %add.ptr109 = getelementptr inbounds ptr, ptr %now, i64 1
  %75 = load ptr, ptr %add.ptr109, align 8
  %add.ptr110 = getelementptr inbounds i64, ptr %75, i64 2
  %76 = load i64, ptr %add.ptr110, align 8
  %sub111 = sub i64 %74, %76
  %add112 = add i64 %sub111, 1
  %shr113 = lshr i64 %add112, 1
  %add.ptr114 = getelementptr inbounds ptr, ptr %now, i64 1
  %77 = load ptr, ptr %add.ptr114, align 8
  %add.ptr115 = getelementptr inbounds i64, ptr %77, i64 2
  %78 = load i64, ptr %add.ptr115, align 8
  %add.ptr116 = getelementptr inbounds ptr, ptr %now, i64 1
  %79 = load ptr, ptr %add.ptr116, align 8
  %add.ptr117 = getelementptr inbounds i64, ptr %79, i64 3
  %80 = load i64, ptr %add.ptr117, align 8
  %add118 = add i64 %78, %80
  %shr119 = lshr i64 %add118, 1
  %81 = load i64, ptr @Q, align 8
  %and120 = and i64 %81, %shr113
  %tobool121 = icmp ne i64 %and120, 0
  br i1 %tobool121, label %if.else129, label %land.lhs.true122

land.lhs.true122:                                 ; preds = %while.body106
  %add.ptr123 = getelementptr inbounds i64, ptr %62, i64 2
  %82 = load i64, ptr %add.ptr123, align 8
  %and124 = and i64 %82, %shr113
  %tobool125 = icmp ne i64 %and124, 0
  br i1 %tobool125, label %if.else129, label %if.then126

if.then126:                                       ; preds = %land.lhs.true122
  %add.ptr127 = getelementptr inbounds ptr, ptr %now, i64 1
  %83 = load ptr, ptr %add.ptr127, align 8
  %add.ptr128 = getelementptr inbounds i64, ptr %83, i64 3
  store i64 %shr119, ptr %add.ptr128, align 8
  br label %if.end142

if.else129:                                       ; preds = %land.lhs.true122, %while.body106
  %84 = load i64, ptr @Q, align 8
  %and130 = and i64 %84, %shr113
  %tobool131 = icmp ne i64 %and130, 0
  br i1 %tobool131, label %land.lhs.true132, label %if.else140

land.lhs.true132:                                 ; preds = %if.else129
  %add.ptr133 = getelementptr inbounds i64, ptr %62, i64 2
  %85 = load i64, ptr %add.ptr133, align 8
  %and134 = and i64 %85, %shr113
  %tobool135 = icmp ne i64 %and134, 0
  br i1 %tobool135, label %if.then136, label %if.else140

if.then136:                                       ; preds = %land.lhs.true132
  %add137 = add i64 %shr119, 1
  %add.ptr138 = getelementptr inbounds ptr, ptr %now, i64 1
  %86 = load ptr, ptr %add.ptr138, align 8
  %add.ptr139 = getelementptr inbounds i64, ptr %86, i64 2
  store i64 %add137, ptr %add.ptr139, align 8
  br label %if.end141

if.else140:                                       ; preds = %land.lhs.true132, %if.else129
  br label %while.end143

if.end141:                                        ; preds = %if.then136
  br label %if.end142

if.end142:                                        ; preds = %if.end141, %if.then126
  br label %while.cond105, !llvm.loop !11

while.end143:                                     ; preds = %if.else140
  br label %if.end144

if.end144:                                        ; preds = %while.end143, %lor.lhs.false78
  %add.ptr145 = getelementptr inbounds ptr, ptr %now, i64 1
  %87 = load ptr, ptr %add.ptr145, align 8
  call void @Xupdate(ptr noundef %87)
  br label %if.end146

if.end146:                                        ; preds = %if.end144, %if.end58
  %add.ptr147 = getelementptr inbounds ptr, ptr %now, i64 1
  %88 = load ptr, ptr %add.ptr147, align 8
  %cmp148 = icmp eq ptr %88, null
  br i1 %cmp148, label %if.then149, label %if.else152

if.then149:                                       ; preds = %if.end146
  %89 = load ptr, ptr %now, align 8
  %add.ptr150 = getelementptr inbounds i64, ptr %89, i64 4
  %90 = load i64, ptr %add.ptr150, align 8
  %add.ptr151 = getelementptr inbounds i64, ptr %now, i64 4
  store i64 %90, ptr %add.ptr151, align 8
  br label %if.end165

if.else152:                                       ; preds = %if.end146
  %91 = load ptr, ptr %now, align 8
  %cmp153 = icmp eq ptr %91, null
  br i1 %cmp153, label %if.then154, label %if.else158

if.then154:                                       ; preds = %if.else152
  %add.ptr155 = getelementptr inbounds ptr, ptr %now, i64 1
  %92 = load ptr, ptr %add.ptr155, align 8
  %add.ptr156 = getelementptr inbounds i64, ptr %92, i64 4
  %93 = load i64, ptr %add.ptr156, align 8
  %add.ptr157 = getelementptr inbounds i64, ptr %now, i64 4
  store i64 %93, ptr %add.ptr157, align 8
  br label %if.end164

if.else158:                                       ; preds = %if.else152
  %94 = load ptr, ptr %now, align 8
  %add.ptr159 = getelementptr inbounds i64, ptr %94, i64 4
  %95 = load i64, ptr %add.ptr159, align 8
  %add.ptr160 = getelementptr inbounds ptr, ptr %now, i64 1
  %96 = load ptr, ptr %add.ptr160, align 8
  %add.ptr161 = getelementptr inbounds i64, ptr %96, i64 4
  %97 = load i64, ptr %add.ptr161, align 8
  %call162 = call i64 @gcd2(i64 noundef %95, i64 noundef %97)
  %add.ptr163 = getelementptr inbounds i64, ptr %now, i64 4
  store i64 %call162, ptr %add.ptr163, align 8
  br label %if.end164

if.end164:                                        ; preds = %if.else158, %if.then154
  br label %if.end165

if.end165:                                        ; preds = %if.end164, %if.then149
  br label %if.end166

if.end166:                                        ; preds = %if.end165, %if.then
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local void @Yupdate(i64 noundef %l, i64 noundef %r, ptr noundef %now) #0 {
entry:
  %add = add i64 %l, %r
  %shr = lshr i64 %add, 1
  %cmp = icmp ult i64 %l, %r
  br i1 %cmp, label %if.then, label %if.end43

if.then:                                          ; preds = %entry
  %0 = load i64, ptr @P, align 8
  %cmp1 = icmp ule i64 %0, %shr
  br i1 %cmp1, label %if.then2, label %if.end6

if.then2:                                         ; preds = %if.then
  %1 = load ptr, ptr %now, align 8
  %cmp3 = icmp eq ptr %1, null
  br i1 %cmp3, label %if.then4, label %if.end

if.then4:                                         ; preds = %if.then2
  %call = call noalias ptr @malloc(i64 noundef 24) #4
  store ptr %call, ptr %now, align 8
  %2 = load ptr, ptr %now, align 8
  store ptr null, ptr %2, align 8
  %3 = load ptr, ptr %now, align 8
  %add.ptr = getelementptr inbounds ptr, ptr %3, i64 1
  store ptr null, ptr %add.ptr, align 8
  %4 = load ptr, ptr %now, align 8
  %add.ptr5 = getelementptr inbounds ptr, ptr %4, i64 2
  store ptr null, ptr %add.ptr5, align 8
  br label %if.end

if.end:                                           ; preds = %if.then4, %if.then2
  %5 = load ptr, ptr %now, align 8
  call void @Yupdate(i64 noundef %l, i64 noundef %shr, ptr noundef %5)
  br label %if.end6

if.end6:                                          ; preds = %if.end, %if.then
  %add7 = add i64 %shr, 1
  %6 = load i64, ptr @P, align 8
  %cmp8 = icmp ule i64 %add7, %6
  br i1 %cmp8, label %if.then9, label %if.end23

if.then9:                                         ; preds = %if.end6
  %add.ptr10 = getelementptr inbounds ptr, ptr %now, i64 1
  %7 = load ptr, ptr %add.ptr10, align 8
  %cmp11 = icmp eq ptr %7, null
  br i1 %cmp11, label %if.then12, label %if.end20

if.then12:                                        ; preds = %if.then9
  %call13 = call noalias ptr @malloc(i64 noundef 24) #4
  %add.ptr14 = getelementptr inbounds ptr, ptr %now, i64 1
  store ptr %call13, ptr %add.ptr14, align 8
  %add.ptr15 = getelementptr inbounds ptr, ptr %now, i64 1
  %8 = load ptr, ptr %add.ptr15, align 8
  store ptr null, ptr %8, align 8
  %add.ptr16 = getelementptr inbounds ptr, ptr %now, i64 1
  %9 = load ptr, ptr %add.ptr16, align 8
  %add.ptr17 = getelementptr inbounds ptr, ptr %9, i64 1
  store ptr null, ptr %add.ptr17, align 8
  %add.ptr18 = getelementptr inbounds ptr, ptr %now, i64 1
  %10 = load ptr, ptr %add.ptr18, align 8
  %add.ptr19 = getelementptr inbounds ptr, ptr %10, i64 2
  store ptr null, ptr %add.ptr19, align 8
  br label %if.end20

if.end20:                                         ; preds = %if.then12, %if.then9
  %add21 = add i64 %shr, 1
  %add.ptr22 = getelementptr inbounds ptr, ptr %now, i64 1
  %11 = load ptr, ptr %add.ptr22, align 8
  call void @Yupdate(i64 noundef %add21, i64 noundef %r, ptr noundef %11)
  br label %if.end23

if.end23:                                         ; preds = %if.end20, %if.end6
  %add.ptr24 = getelementptr inbounds ptr, ptr %now, i64 1
  %12 = load ptr, ptr %add.ptr24, align 8
  %cmp25 = icmp eq ptr %12, null
  br i1 %cmp25, label %if.then26, label %if.else

if.then26:                                        ; preds = %if.end23
  %13 = load ptr, ptr %now, align 8
  %add.ptr27 = getelementptr inbounds ptr, ptr %13, i64 2
  %14 = load ptr, ptr %add.ptr27, align 8
  %call28 = call i64 @Xcalculate(ptr noundef %14)
  store i64 %call28, ptr @K, align 8
  br label %if.end42

if.else:                                          ; preds = %if.end23
  %15 = load ptr, ptr %now, align 8
  %cmp29 = icmp eq ptr %15, null
  br i1 %cmp29, label %if.then30, label %if.else34

if.then30:                                        ; preds = %if.else
  %add.ptr31 = getelementptr inbounds ptr, ptr %now, i64 1
  %16 = load ptr, ptr %add.ptr31, align 8
  %add.ptr32 = getelementptr inbounds ptr, ptr %16, i64 2
  %17 = load ptr, ptr %add.ptr32, align 8
  %call33 = call i64 @Xcalculate(ptr noundef %17)
  store i64 %call33, ptr @K, align 8
  br label %if.end41

if.else34:                                        ; preds = %if.else
  %18 = load ptr, ptr %now, align 8
  %add.ptr35 = getelementptr inbounds ptr, ptr %18, i64 2
  %19 = load ptr, ptr %add.ptr35, align 8
  %call36 = call i64 @Xcalculate(ptr noundef %19)
  %add.ptr37 = getelementptr inbounds ptr, ptr %now, i64 1
  %20 = load ptr, ptr %add.ptr37, align 8
  %add.ptr38 = getelementptr inbounds ptr, ptr %20, i64 2
  %21 = load ptr, ptr %add.ptr38, align 8
  %call39 = call i64 @Xcalculate(ptr noundef %21)
  %call40 = call i64 @gcd2(i64 noundef %call36, i64 noundef %call39)
  store i64 %call40, ptr @K, align 8
  br label %if.end41

if.end41:                                         ; preds = %if.else34, %if.then30
  br label %if.end42

if.end42:                                         ; preds = %if.end41, %if.then26
  br label %if.end43

if.end43:                                         ; preds = %if.end42, %entry
  %add.ptr44 = getelementptr inbounds ptr, ptr %now, i64 2
  %22 = load ptr, ptr %add.ptr44, align 8
  %cmp45 = icmp eq ptr %22, null
  br i1 %cmp45, label %if.then46, label %if.end58

if.then46:                                        ; preds = %if.end43
  %call47 = call noalias ptr @malloc(i64 noundef 40) #4
  %add.ptr48 = getelementptr inbounds ptr, ptr %now, i64 2
  store ptr %call47, ptr %add.ptr48, align 8
  %add.ptr49 = getelementptr inbounds ptr, ptr %now, i64 2
  %23 = load ptr, ptr %add.ptr49, align 8
  store ptr null, ptr %23, align 8
  %add.ptr50 = getelementptr inbounds ptr, ptr %now, i64 2
  %24 = load ptr, ptr %add.ptr50, align 8
  %add.ptr51 = getelementptr inbounds ptr, ptr %24, i64 1
  store ptr null, ptr %add.ptr51, align 8
  %add.ptr52 = getelementptr inbounds ptr, ptr %now, i64 2
  %25 = load ptr, ptr %add.ptr52, align 8
  %add.ptr53 = getelementptr inbounds i64, ptr %25, i64 2
  store i64 0, ptr %add.ptr53, align 8
  %26 = load i64, ptr @C, align 8
  %sub = sub i64 %26, 1
  %add.ptr54 = getelementptr inbounds ptr, ptr %now, i64 2
  %27 = load ptr, ptr %add.ptr54, align 8
  %add.ptr55 = getelementptr inbounds i64, ptr %27, i64 3
  store i64 %sub, ptr %add.ptr55, align 8
  %add.ptr56 = getelementptr inbounds ptr, ptr %now, i64 2
  %28 = load ptr, ptr %add.ptr56, align 8
  %add.ptr57 = getelementptr inbounds i64, ptr %28, i64 4
  store i64 0, ptr %add.ptr57, align 8
  br label %if.end58

if.end58:                                         ; preds = %if.then46, %if.end43
  %add.ptr59 = getelementptr inbounds ptr, ptr %now, i64 2
  %29 = load ptr, ptr %add.ptr59, align 8
  call void @Xupdate(ptr noundef %29)
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local void @update(i64 noundef %P_, i64 noundef %Q_, i64 noundef %K_) #0 {
entry:
  store i64 %P_, ptr @P, align 8
  store i64 %Q_, ptr @Q, align 8
  store i64 %K_, ptr @K, align 8
  %0 = load i64, ptr @Q, align 8
  store i64 %0, ptr @V, align 8
  %1 = load i64, ptr @R, align 8
  %sub = sub i64 %1, 1
  %2 = load ptr, ptr @Yroot, align 8
  call void @Yupdate(i64 noundef 0, i64 noundef %sub, ptr noundef %2)
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local i64 @calculate(i64 noundef %P_, i64 noundef %Q_, i64 noundef %U_, i64 noundef %V_) #0 {
entry:
  store i64 %P_, ptr @P, align 8
  store i64 %Q_, ptr @Q, align 8
  store i64 %U_, ptr @U, align 8
  store i64 %V_, ptr @V, align 8
  %0 = load i64, ptr @R, align 8
  %sub = sub i64 %0, 1
  %1 = load ptr, ptr @Yroot, align 8
  %call = call i64 @Ycalculate(i64 noundef 0, i64 noundef %sub, ptr noundef %1)
  ret i64 %call
}

; Function Attrs: nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  %call = call i64 (...) @read()
  %call1 = call i64 (...) @read()
  %call2 = call i64 (...) @read()
  call void @init(i64 noundef %call, i64 noundef %call1)
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i64 [ 0, %entry ], [ %inc, %for.inc ]
  %cmp = icmp ult i64 %i.0, %call2
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %call3 = call i64 (...) @read()
  %cmp4 = icmp eq i64 %call3, 1
  br i1 %cmp4, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %call5 = call i64 (...) @read()
  %call6 = call i64 (...) @read()
  %call7 = call i64 (...) @read()
  call void @update(i64 noundef %call5, i64 noundef %call6, i64 noundef %call7)
  br label %if.end

if.else:                                          ; preds = %for.body
  %call8 = call i64 (...) @read()
  %call9 = call i64 (...) @read()
  %call10 = call i64 (...) @read()
  %call11 = call i64 (...) @read()
  %call12 = call i64 @calculate(i64 noundef %call8, i64 noundef %call9, i64 noundef %call10, i64 noundef %call11)
  call void @write(i64 noundef %call12)
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %inc = add i64 %i.0, 1
  br label %for.cond, !llvm.loop !12

for.end:                                          ; preds = %for.cond
  ret i32 0
}

declare i64 @read(...) #3

declare void @write(i64 noundef) #3

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nounwind allocsize(0) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind allocsize(0) }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"clang version 18.1.0rc (https://github.com/llvm/llvm-project.git 461274b81d8641eab64d494accddc81d7db8a09e)"}
!5 = distinct !{!5, !6, !7}
!6 = !{!"llvm.loop.mustprogress"}
!7 = !{!"llvm.loop.unroll.disable"}
!8 = distinct !{!8, !6, !7}
!9 = distinct !{!9, !6, !7}
!10 = distinct !{!10, !7}
!11 = distinct !{!11, !7}
!12 = distinct !{!12, !6, !7}
