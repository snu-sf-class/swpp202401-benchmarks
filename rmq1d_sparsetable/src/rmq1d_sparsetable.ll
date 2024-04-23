; ModuleID = '.tmp/a.ll'
source_filename = "rmq1d_sparsetable/src/rmq1d_sparsetable.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@N = external global i32, align 4
@height = external global i32, align 4
@A = external global ptr, align 8
@input = external global ptr, align 8

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
define dso_local void @initA() #0 {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %j.0 = phi i64 [ 0, %entry ], [ %inc, %while.body ]
  %sh_prom = trunc i64 %j.0 to i32
  %shl = shl i32 1, %sh_prom
  %conv = sext i32 %shl to i64
  %0 = load i32, ptr @N, align 4
  %conv1 = sext i32 %0 to i64
  %cmp = icmp sle i64 %conv, %conv1
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %inc = add nsw i64 %j.0, 1
  br label %while.cond, !llvm.loop !5

while.end:                                        ; preds = %while.cond
  %conv3 = trunc i64 %j.0 to i32
  store i32 %conv3, ptr @height, align 4
  %1 = load i32, ptr @height, align 4
  %conv4 = sext i32 %1 to i64
  %mul = mul i64 8, %conv4
  %call = call ptr @malloc_upto_8(i64 noundef %mul)
  store ptr %call, ptr @A, align 8
  %2 = load ptr, ptr @input, align 8
  %3 = load ptr, ptr @A, align 8
  %arrayidx = getelementptr inbounds ptr, ptr %3, i64 0
  store ptr %2, ptr %arrayidx, align 8
  br label %while.cond5

while.cond5:                                      ; preds = %for.end, %while.end
  %j.1 = phi i64 [ 1, %while.end ], [ %inc35, %for.end ]
  %sh_prom6 = trunc i64 %j.1 to i32
  %shl7 = shl i32 1, %sh_prom6
  %conv8 = sext i32 %shl7 to i64
  %4 = load i32, ptr @N, align 4
  %conv9 = sext i32 %4 to i64
  %cmp10 = icmp sle i64 %conv8, %conv9
  br i1 %cmp10, label %while.body12, label %while.end36

while.body12:                                     ; preds = %while.cond5
  %sh_prom13 = trunc i64 %j.1 to i32
  %shl14 = shl i32 1, %sh_prom13
  %5 = load i32, ptr @N, align 4
  %sub = sub nsw i32 %5, %shl14
  %add = add nsw i32 %sub, 1
  %conv15 = sext i32 %add to i64
  %mul16 = mul i64 4, %conv15
  %call17 = call ptr @malloc_upto_8(i64 noundef %mul16)
  %6 = load ptr, ptr @A, align 8
  %arrayidx18 = getelementptr inbounds ptr, ptr %6, i64 %j.1
  store ptr %call17, ptr %arrayidx18, align 8
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %while.body12
  %i.0 = phi i32 [ 0, %while.body12 ], [ %inc34, %for.inc ]
  %7 = load i32, ptr @N, align 4
  %sub19 = sub nsw i32 %7, %shl14
  %cmp20 = icmp sle i32 %i.0, %sub19
  br i1 %cmp20, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond
  br label %for.end

for.body:                                         ; preds = %for.cond
  %8 = load ptr, ptr @A, align 8
  %sub22 = sub nsw i64 %j.1, 1
  %arrayidx23 = getelementptr inbounds ptr, ptr %8, i64 %sub22
  %9 = load ptr, ptr %arrayidx23, align 8
  %idxprom = sext i32 %i.0 to i64
  %arrayidx24 = getelementptr inbounds i32, ptr %9, i64 %idxprom
  %10 = load i32, ptr %arrayidx24, align 4
  %11 = load ptr, ptr @A, align 8
  %sub25 = sub nsw i64 %j.1, 1
  %arrayidx26 = getelementptr inbounds ptr, ptr %11, i64 %sub25
  %12 = load ptr, ptr %arrayidx26, align 8
  %div = sdiv i32 %shl14, 2
  %add27 = add nsw i32 %i.0, %div
  %idxprom28 = sext i32 %add27 to i64
  %arrayidx29 = getelementptr inbounds i32, ptr %12, i64 %idxprom28
  %13 = load i32, ptr %arrayidx29, align 4
  %call30 = call i32 @min(i32 noundef %10, i32 noundef %13)
  %14 = load ptr, ptr @A, align 8
  %arrayidx31 = getelementptr inbounds ptr, ptr %14, i64 %j.1
  %15 = load ptr, ptr %arrayidx31, align 8
  %idxprom32 = sext i32 %i.0 to i64
  %arrayidx33 = getelementptr inbounds i32, ptr %15, i64 %idxprom32
  store i32 %call30, ptr %arrayidx33, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc34 = add nsw i32 %i.0, 1
  br label %for.cond, !llvm.loop !8

for.end:                                          ; preds = %for.cond.cleanup
  %inc35 = add nsw i64 %j.1, 1
  br label %while.cond5, !llvm.loop !9

while.end36:                                      ; preds = %while.cond5
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #2

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
  br label %for.cond, !llvm.loop !10

cleanup:                                          ; preds = %if.then, %for.cond.cleanup
  br label %for.end

for.end:                                          ; preds = %cleanup
  ret i32 %count.0
}

; Function Attrs: nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  %call = call i64 (...) @read()
  %conv = trunc i64 %call to i32
  store i32 %conv, ptr @N, align 4
  %0 = load i32, ptr @N, align 4
  %conv1 = sext i32 %0 to i64
  %mul = mul i64 4, %conv1
  %call2 = call ptr @malloc_upto_8(i64 noundef %mul)
  store ptr %call2, ptr @input, align 8
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.inc ]
  %1 = load i32, ptr @N, align 4
  %cmp = icmp slt i32 %i.0, %1
  br i1 %cmp, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond
  br label %for.end

for.body:                                         ; preds = %for.cond
  %call4 = call i64 (...) @read()
  %conv5 = trunc i64 %call4 to i32
  %2 = load ptr, ptr @input, align 8
  %idxprom = sext i32 %i.0 to i64
  %arrayidx = getelementptr inbounds i32, ptr %2, i64 %idxprom
  store i32 %conv5, ptr %arrayidx, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %i.0, 1
  br label %for.cond, !llvm.loop !11

for.end:                                          ; preds = %for.cond.cleanup
  call void @initA()
  %call6 = call i64 (...) @read()
  %conv7 = trunc i64 %call6 to i32
  br label %while.cond

while.cond:                                       ; preds = %while.body, %for.end
  %Q.0 = phi i32 [ %conv7, %for.end ], [ %dec, %while.body ]
  %dec = add nsw i32 %Q.0, -1
  %tobool = icmp ne i32 %Q.0, 0
  br i1 %tobool, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %call8 = call i64 (...) @read()
  %conv9 = trunc i64 %call8 to i32
  %call10 = call i64 (...) @read()
  %conv11 = trunc i64 %call10 to i32
  %sub = sub nsw i32 %conv11, %conv9
  %add = add nsw i32 %sub, 1
  %call12 = call i32 @count_leading_zeros(i32 noundef %add)
  %sub13 = sub nsw i32 32, %call12
  %3 = load ptr, ptr @A, align 8
  %sub14 = sub nsw i32 %sub13, 1
  %idxprom15 = sext i32 %sub14 to i64
  %arrayidx16 = getelementptr inbounds ptr, ptr %3, i64 %idxprom15
  %4 = load ptr, ptr %arrayidx16, align 8
  %idxprom17 = sext i32 %conv9 to i64
  %arrayidx18 = getelementptr inbounds i32, ptr %4, i64 %idxprom17
  %5 = load i32, ptr %arrayidx18, align 4
  %6 = load ptr, ptr @A, align 8
  %sub19 = sub nsw i32 %sub13, 1
  %idxprom20 = sext i32 %sub19 to i64
  %arrayidx21 = getelementptr inbounds ptr, ptr %6, i64 %idxprom20
  %7 = load ptr, ptr %arrayidx21, align 8
  %sub22 = sub nsw i32 %sub13, 1
  %shl = shl i32 1, %sub22
  %sub23 = sub nsw i32 %conv11, %shl
  %add24 = add nsw i32 %sub23, 1
  %idxprom25 = sext i32 %add24 to i64
  %arrayidx26 = getelementptr inbounds i32, ptr %7, i64 %idxprom25
  %8 = load i32, ptr %arrayidx26, align 4
  %call27 = call i32 @min(i32 noundef %5, i32 noundef %8)
  %conv28 = sext i32 %call27 to i64
  call void @write(i64 noundef %conv28)
  br label %while.cond, !llvm.loop !12

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
