; ModuleID = '.tmp/a.ll'
source_filename = "rmq2d_sparsetable/src/rmq2d_sparsetable.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@_input = external global ptr, align 8
@M = external global i32, align 4
@N = external global i32, align 4
@_A = external global ptr, align 8
@M2 = external global i32, align 4
@N2 = external global i32, align 4

; Function Attrs: nounwind uwtable
define dso_local ptr @malloc_upto_8(i64 noundef %x) #0 {
entry:
  %add = add i64 %x, 7
  %div = udiv i64 %add, 8
  %mul = mul i64 %div, 8
  %call = call noalias ptr @malloc(i64 noundef %mul) #4
  ret ptr %call
}

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #1

; Function Attrs: nounwind uwtable
define dso_local i32 @min(i32 noundef %x, i32 noundef %y) #0 {
entry:
  %cmp = icmp slt i32 %x, %y
  br i1 %cmp, label %cond.true, label %cond.false

cond.true:                                        ; preds = %entry
  br label %cond.end

cond.false:                                       ; preds = %entry
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %x, %cond.true ], [ %y, %cond.false ]
  ret i32 %cond
}

; Function Attrs: nounwind uwtable
define dso_local i32 @count_leading_zeros(i32 noundef %x) #0 {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %count.0 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %i.0 = phi i32 [ 31, %entry ], [ %dec, %for.inc ]
  %cmp = icmp sge i32 %i.0, 0
  br i1 %cmp, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond
  br label %cleanup

for.body:                                         ; preds = %for.cond
  %shl = shl i32 1, %i.0
  %and = and i32 %x, %shl
  %tobool = icmp ne i32 %and, 0
  br i1 %tobool, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  br label %cleanup

if.end:                                           ; preds = %for.body
  %inc = add nsw i32 %count.0, 1
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %dec = add nsw i32 %i.0, -1
  br label %for.cond, !llvm.loop !5

cleanup:                                          ; preds = %if.then, %for.cond.cleanup
  br label %for.end

for.end:                                          ; preds = %cleanup
  ret i32 %count.0
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: nounwind uwtable
define dso_local i32 @floorlog2(i32 noundef %x) #0 {
entry:
  %call = call i32 @count_leading_zeros(i32 noundef %x)
  %sub = sub nsw i32 32, %call
  %sub1 = sub nsw i32 %sub, 1
  ret i32 %sub1
}

; Function Attrs: nounwind uwtable
define dso_local ptr @input(i32 noundef %i, i32 noundef %j) #0 {
entry:
  %0 = load ptr, ptr @_input, align 8
  %1 = load i32, ptr @M, align 4
  %mul = mul nsw i32 %i, %1
  %add = add nsw i32 %mul, %j
  %idxprom = sext i32 %add to i64
  %arrayidx = getelementptr inbounds i32, ptr %0, i64 %idxprom
  ret ptr %arrayidx
}

; Function Attrs: nounwind uwtable
define dso_local i32 @width(i32 noundef %j) #0 {
entry:
  %0 = load i32, ptr @M, align 4
  %shl = shl i32 1, %j
  %sub = sub nsw i32 %0, %shl
  %add = add nsw i32 %sub, 1
  ret i32 %add
}

; Function Attrs: nounwind uwtable
define dso_local i32 @height(i32 noundef %i) #0 {
entry:
  %0 = load i32, ptr @N, align 4
  %shl = shl i32 1, %i
  %sub = sub nsw i32 %0, %shl
  %add = add nsw i32 %sub, 1
  ret i32 %add
}

; Function Attrs: nounwind uwtable
define dso_local ptr @A(i32 noundef %i, i32 noundef %j) #0 {
entry:
  %0 = load ptr, ptr @_A, align 8
  %1 = load i32, ptr @M2, align 4
  %add = add nsw i32 %1, 1
  %mul = mul nsw i32 %i, %add
  %add1 = add nsw i32 %mul, %j
  %idxprom = sext i32 %add1 to i64
  %arrayidx = getelementptr inbounds ptr, ptr %0, i64 %idxprom
  ret ptr %arrayidx
}

; Function Attrs: nounwind uwtable
define dso_local i32 @P(i32 noundef %i, i32 noundef %j, i32 noundef %ii, i32 noundef %jj) #0 {
entry:
  %call = call ptr @A(i32 noundef %i, i32 noundef %j)
  %0 = load ptr, ptr %call, align 8
  %call1 = call i32 @width(i32 noundef %j)
  %mul = mul nsw i32 %ii, %call1
  %add = add nsw i32 %mul, %jj
  %idxprom = sext i32 %add to i64
  %arrayidx = getelementptr inbounds i32, ptr %0, i64 %idxprom
  %1 = load i32, ptr %arrayidx, align 4
  ret i32 %1
}

; Function Attrs: nounwind uwtable
define dso_local void @preprocess() #0 {
entry:
  %0 = load i32, ptr @N, align 4
  %call = call i32 @floorlog2(i32 noundef %0)
  store i32 %call, ptr @N2, align 4
  %1 = load i32, ptr @M, align 4
  %call1 = call i32 @floorlog2(i32 noundef %1)
  store i32 %call1, ptr @M2, align 4
  %2 = load i32, ptr @N2, align 4
  %add = add nsw i32 %2, 1
  %conv = sext i32 %add to i64
  %mul = mul i64 8, %conv
  %3 = load i32, ptr @M2, align 4
  %add2 = add nsw i32 %3, 1
  %conv3 = sext i32 %add2 to i64
  %mul4 = mul i64 %mul, %conv3
  %call5 = call ptr @malloc_upto_8(i64 noundef %mul4)
  store ptr %call5, ptr @_A, align 8
  %4 = load ptr, ptr @_input, align 8
  %call6 = call ptr @A(i32 noundef 0, i32 noundef 0)
  store ptr %4, ptr %call6, align 8
  br label %for.cond

for.cond:                                         ; preds = %for.inc24, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc25, %for.inc24 ]
  %5 = load i32, ptr @N2, align 4
  %cmp = icmp sle i32 %i.0, %5
  br i1 %cmp, label %for.body, label %for.end26

for.body:                                         ; preds = %for.cond
  br label %for.cond8

for.cond8:                                        ; preds = %for.inc, %for.body
  %j.0 = phi i32 [ 0, %for.body ], [ %inc, %for.inc ]
  %6 = load i32, ptr @M2, align 4
  %cmp9 = icmp sle i32 %j.0, %6
  br i1 %cmp9, label %for.body11, label %for.end

for.body11:                                       ; preds = %for.cond8
  %cmp12 = icmp eq i32 %i.0, 0
  br i1 %cmp12, label %land.lhs.true, label %if.end

land.lhs.true:                                    ; preds = %for.body11
  %cmp14 = icmp eq i32 %j.0, 0
  br i1 %cmp14, label %if.then, label %if.end

if.then:                                          ; preds = %land.lhs.true
  br label %for.inc

if.end:                                           ; preds = %land.lhs.true, %for.body11
  %call16 = call i32 @height(i32 noundef %i.0)
  %conv17 = sext i32 %call16 to i64
  %mul18 = mul i64 4, %conv17
  %call19 = call i32 @width(i32 noundef %j.0)
  %conv20 = sext i32 %call19 to i64
  %mul21 = mul i64 %mul18, %conv20
  %call22 = call ptr @malloc_upto_8(i64 noundef %mul21)
  %call23 = call ptr @A(i32 noundef %i.0, i32 noundef %j.0)
  store ptr %call22, ptr %call23, align 8
  br label %for.inc

for.inc:                                          ; preds = %if.end, %if.then
  %inc = add nsw i32 %j.0, 1
  br label %for.cond8, !llvm.loop !8

for.end:                                          ; preds = %for.cond8
  br label %for.inc24

for.inc24:                                        ; preds = %for.end
  %inc25 = add nsw i32 %i.0, 1
  br label %for.cond, !llvm.loop !9

for.end26:                                        ; preds = %for.cond
  br label %for.cond27

for.cond27:                                       ; preds = %for.inc110, %for.end26
  %i.1 = phi i32 [ 0, %for.end26 ], [ %inc111, %for.inc110 ]
  %7 = load i32, ptr @N2, align 4
  %cmp28 = icmp sle i32 %i.1, %7
  br i1 %cmp28, label %for.body30, label %for.end112

for.body30:                                       ; preds = %for.cond27
  br label %for.cond31

for.cond31:                                       ; preds = %for.inc107, %for.body30
  %j.1 = phi i32 [ 0, %for.body30 ], [ %inc108, %for.inc107 ]
  %8 = load i32, ptr @M2, align 4
  %cmp32 = icmp sle i32 %j.1, %8
  br i1 %cmp32, label %for.body34, label %for.end109

for.body34:                                       ; preds = %for.cond31
  %cmp35 = icmp eq i32 %i.1, 0
  br i1 %cmp35, label %land.lhs.true37, label %if.end41

land.lhs.true37:                                  ; preds = %for.body34
  %cmp38 = icmp eq i32 %j.1, 0
  br i1 %cmp38, label %if.then40, label %if.end41

if.then40:                                        ; preds = %land.lhs.true37
  br label %for.inc107

if.end41:                                         ; preds = %land.lhs.true37, %for.body34
  %call42 = call ptr @A(i32 noundef %i.1, i32 noundef %j.1)
  %9 = load ptr, ptr %call42, align 8
  br label %for.cond43

for.cond43:                                       ; preds = %for.inc104, %if.end41
  %ii.0 = phi i32 [ 0, %if.end41 ], [ %inc105, %for.inc104 ]
  %call44 = call i32 @height(i32 noundef %i.1)
  %cmp45 = icmp slt i32 %ii.0, %call44
  br i1 %cmp45, label %for.body47, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond43
  br label %for.end106

for.body47:                                       ; preds = %for.cond43
  br label %for.cond48

for.cond48:                                       ; preds = %for.inc101, %for.body47
  %jj.0 = phi i32 [ 0, %for.body47 ], [ %inc102, %for.inc101 ]
  %call49 = call i32 @width(i32 noundef %j.1)
  %cmp50 = icmp slt i32 %jj.0, %call49
  br i1 %cmp50, label %for.body53, label %for.cond.cleanup52

for.cond.cleanup52:                               ; preds = %for.cond48
  br label %for.end103

for.body53:                                       ; preds = %for.cond48
  %cmp54 = icmp ne i32 %j.1, 0
  br i1 %cmp54, label %if.then56, label %if.else

if.then56:                                        ; preds = %for.body53
  %sub = sub nsw i32 %j.1, 1
  %call57 = call ptr @A(i32 noundef %i.1, i32 noundef %sub)
  %10 = load ptr, ptr %call57, align 8
  %sub58 = sub nsw i32 %j.1, 1
  %call59 = call i32 @width(i32 noundef %sub58)
  %mul60 = mul nsw i32 %ii.0, %call59
  %add61 = add nsw i32 %mul60, %jj.0
  %idxprom = sext i32 %add61 to i64
  %arrayidx = getelementptr inbounds i32, ptr %10, i64 %idxprom
  %11 = load i32, ptr %arrayidx, align 4
  %mul62 = mul nsw i32 %ii.0, %call59
  %add63 = add nsw i32 %mul62, %jj.0
  %sub64 = sub nsw i32 %j.1, 1
  %shl = shl i32 1, %sub64
  %add65 = add nsw i32 %add63, %shl
  %idxprom66 = sext i32 %add65 to i64
  %arrayidx67 = getelementptr inbounds i32, ptr %10, i64 %idxprom66
  %12 = load i32, ptr %arrayidx67, align 4
  %call68 = call i32 @min(i32 noundef %11, i32 noundef %12)
  %call69 = call i32 @width(i32 noundef %j.1)
  %mul70 = mul nsw i32 %ii.0, %call69
  %add71 = add nsw i32 %mul70, %jj.0
  %idxprom72 = sext i32 %add71 to i64
  %arrayidx73 = getelementptr inbounds i32, ptr %9, i64 %idxprom72
  store i32 %call68, ptr %arrayidx73, align 4
  br label %if.end100

if.else:                                          ; preds = %for.body53
  %sub75 = sub nsw i32 %i.1, 1
  %call76 = call ptr @A(i32 noundef %sub75, i32 noundef %j.1)
  %13 = load ptr, ptr %call76, align 8
  %sub77 = sub nsw i32 %i.1, 1
  %call78 = call i32 @height(i32 noundef %sub77)
  %call80 = call i32 @width(i32 noundef %j.1)
  %mul81 = mul nsw i32 %ii.0, %call80
  %add82 = add nsw i32 %mul81, %jj.0
  %idxprom83 = sext i32 %add82 to i64
  %arrayidx84 = getelementptr inbounds i32, ptr %13, i64 %idxprom83
  %14 = load i32, ptr %arrayidx84, align 4
  %sub86 = sub nsw i32 %i.1, 1
  %shl87 = shl i32 1, %sub86
  %add88 = add nsw i32 %ii.0, %shl87
  %call89 = call i32 @width(i32 noundef %j.1)
  %mul90 = mul nsw i32 %add88, %call89
  %add91 = add nsw i32 %mul90, %jj.0
  %idxprom92 = sext i32 %add91 to i64
  %arrayidx93 = getelementptr inbounds i32, ptr %13, i64 %idxprom92
  %15 = load i32, ptr %arrayidx93, align 4
  %call94 = call i32 @min(i32 noundef %14, i32 noundef %15)
  %call95 = call i32 @width(i32 noundef %j.1)
  %mul96 = mul nsw i32 %ii.0, %call95
  %add97 = add nsw i32 %mul96, %jj.0
  %idxprom98 = sext i32 %add97 to i64
  %arrayidx99 = getelementptr inbounds i32, ptr %9, i64 %idxprom98
  store i32 %call94, ptr %arrayidx99, align 4
  br label %if.end100

if.end100:                                        ; preds = %if.else, %if.then56
  br label %for.inc101

for.inc101:                                       ; preds = %if.end100
  %inc102 = add nsw i32 %jj.0, 1
  br label %for.cond48, !llvm.loop !10

for.end103:                                       ; preds = %for.cond.cleanup52
  br label %for.inc104

for.inc104:                                       ; preds = %for.end103
  %inc105 = add nsw i32 %ii.0, 1
  br label %for.cond43, !llvm.loop !11

for.end106:                                       ; preds = %for.cond.cleanup
  br label %for.inc107

for.inc107:                                       ; preds = %for.end106, %if.then40
  %inc108 = add nsw i32 %j.1, 1
  br label %for.cond31, !llvm.loop !12

for.end109:                                       ; preds = %for.cond31
  br label %for.inc110

for.inc110:                                       ; preds = %for.end109
  %inc111 = add nsw i32 %i.1, 1
  br label %for.cond27, !llvm.loop !13

for.end112:                                       ; preds = %for.cond27
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  %call = call i64 (...) @read()
  %conv = trunc i64 %call to i32
  store i32 %conv, ptr @N, align 4
  %call1 = call i64 (...) @read()
  %conv2 = trunc i64 %call1 to i32
  store i32 %conv2, ptr @M, align 4
  %0 = load i32, ptr @N, align 4
  %conv3 = sext i32 %0 to i64
  %mul = mul i64 4, %conv3
  %1 = load i32, ptr @M, align 4
  %conv4 = sext i32 %1 to i64
  %mul5 = mul i64 %mul, %conv4
  %call6 = call ptr @malloc_upto_8(i64 noundef %mul5)
  store ptr %call6, ptr @_input, align 8
  br label %for.cond

for.cond:                                         ; preds = %for.inc16, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc17, %for.inc16 ]
  %2 = load i32, ptr @N, align 4
  %cmp = icmp slt i32 %i.0, %2
  br i1 %cmp, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond
  br label %for.end18

for.body:                                         ; preds = %for.cond
  br label %for.cond8

for.cond8:                                        ; preds = %for.inc, %for.body
  %j.0 = phi i32 [ 0, %for.body ], [ %inc, %for.inc ]
  %3 = load i32, ptr @M, align 4
  %cmp9 = icmp slt i32 %j.0, %3
  br i1 %cmp9, label %for.body12, label %for.cond.cleanup11

for.cond.cleanup11:                               ; preds = %for.cond8
  br label %for.end

for.body12:                                       ; preds = %for.cond8
  %call13 = call i64 (...) @read()
  %conv14 = trunc i64 %call13 to i32
  %call15 = call ptr @input(i32 noundef %i.0, i32 noundef %j.0)
  store i32 %conv14, ptr %call15, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body12
  %inc = add nsw i32 %j.0, 1
  br label %for.cond8, !llvm.loop !14

for.end:                                          ; preds = %for.cond.cleanup11
  br label %for.inc16

for.inc16:                                        ; preds = %for.end
  %inc17 = add nsw i32 %i.0, 1
  br label %for.cond, !llvm.loop !15

for.end18:                                        ; preds = %for.cond.cleanup
  call void @preprocess()
  %call19 = call i64 (...) @read()
  %conv20 = trunc i64 %call19 to i32
  br label %while.cond

while.cond:                                       ; preds = %while.body, %for.end18
  %Q.0 = phi i32 [ %conv20, %for.end18 ], [ %dec, %while.body ]
  %dec = add nsw i32 %Q.0, -1
  %tobool = icmp ne i32 %Q.0, 0
  br i1 %tobool, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %call21 = call i64 (...) @read()
  %conv22 = trunc i64 %call21 to i32
  %call23 = call i64 (...) @read()
  %conv24 = trunc i64 %call23 to i32
  %call25 = call i64 (...) @read()
  %conv26 = trunc i64 %call25 to i32
  %call27 = call i64 (...) @read()
  %conv28 = trunc i64 %call27 to i32
  %sub = sub nsw i32 %conv24, %conv22
  %add = add nsw i32 %sub, 1
  %call29 = call i32 @floorlog2(i32 noundef %add)
  %sub30 = sub nsw i32 %conv28, %conv26
  %add31 = add nsw i32 %sub30, 1
  %call32 = call i32 @floorlog2(i32 noundef %add31)
  %call33 = call i32 @P(i32 noundef %call29, i32 noundef %call32, i32 noundef %conv22, i32 noundef %conv26)
  %add34 = add nsw i32 %conv24, 1
  %shl = shl i32 1, %call29
  %sub35 = sub nsw i32 %add34, %shl
  %call36 = call i32 @P(i32 noundef %call29, i32 noundef %call32, i32 noundef %sub35, i32 noundef %conv26)
  %add37 = add nsw i32 %conv28, 1
  %shl38 = shl i32 1, %call32
  %sub39 = sub nsw i32 %add37, %shl38
  %call40 = call i32 @P(i32 noundef %call29, i32 noundef %call32, i32 noundef %conv22, i32 noundef %sub39)
  %add41 = add nsw i32 %conv24, 1
  %shl42 = shl i32 1, %call29
  %sub43 = sub nsw i32 %add41, %shl42
  %add44 = add nsw i32 %conv28, 1
  %shl45 = shl i32 1, %call32
  %sub46 = sub nsw i32 %add44, %shl45
  %call47 = call i32 @P(i32 noundef %call29, i32 noundef %call32, i32 noundef %sub43, i32 noundef %sub46)
  %call48 = call i32 @min(i32 noundef %call33, i32 noundef %call36)
  %call49 = call i32 @min(i32 noundef %call40, i32 noundef %call47)
  %call50 = call i32 @min(i32 noundef %call48, i32 noundef %call49)
  %conv51 = sext i32 %call50 to i64
  call void @write(i64 noundef %conv51)
  br label %while.cond, !llvm.loop !16

while.end:                                        ; preds = %while.cond
  ret i32 0
}

declare i64 @read(...) #3

declare void @write(i64 noundef) #3

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nounwind allocsize(0) "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
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
!10 = distinct !{!10, !6, !7}
!11 = distinct !{!11, !6, !7}
!12 = distinct !{!12, !6, !7}
!13 = distinct !{!13, !6, !7}
!14 = distinct !{!14, !6, !7}
!15 = distinct !{!15, !6, !7}
!16 = distinct !{!16, !6, !7}
