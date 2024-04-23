; ModuleID = '.tmp/a.ll'
source_filename = "rmq2d_naive/src/rmq2d_naive.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@v = external global ptr, align 8

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
define dso_local ptr @min_element(ptr noundef %p, ptr noundef %q) #0 {
entry:
  br label %while.cond

while.cond:                                       ; preds = %if.end, %entry
  %p.addr.0 = phi ptr [ %p, %entry ], [ %incdec.ptr, %if.end ]
  %e.0 = phi ptr [ %p, %entry ], [ %e.1, %if.end ]
  %cmp = icmp ne ptr %p.addr.0, %q
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %0 = load i32, ptr %p.addr.0, align 4
  %1 = load i32, ptr %e.0, align 4
  %cmp1 = icmp slt i32 %0, %1
  br i1 %cmp1, label %if.then, label %if.end

if.then:                                          ; preds = %while.body
  br label %if.end

if.end:                                           ; preds = %if.then, %while.body
  %e.1 = phi ptr [ %p.addr.0, %if.then ], [ %e.0, %while.body ]
  %incdec.ptr = getelementptr inbounds i32, ptr %p.addr.0, i64 1
  br label %while.cond, !llvm.loop !5

while.end:                                        ; preds = %while.cond
  ret ptr %e.0
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: nounwind uwtable
define dso_local i32 @min_at_row(i32 noundef %row, i32 noundef %from_j, i32 noundef %to_j) #0 {
entry:
  %0 = load ptr, ptr @v, align 8
  %idx.ext = sext i32 %row to i64
  %add.ptr = getelementptr inbounds ptr, ptr %0, i64 %idx.ext
  %1 = load ptr, ptr %add.ptr, align 8
  %idx.ext1 = sext i32 %from_j to i64
  %add.ptr2 = getelementptr inbounds i32, ptr %1, i64 %idx.ext1
  %2 = load ptr, ptr %add.ptr, align 8
  %idx.ext3 = sext i32 %to_j to i64
  %add.ptr4 = getelementptr inbounds i32, ptr %2, i64 %idx.ext3
  %add.ptr5 = getelementptr inbounds i32, ptr %add.ptr4, i64 1
  %call = call ptr @min_element(ptr noundef %add.ptr2, ptr noundef %add.ptr5)
  %3 = load i32, ptr %call, align 4
  ret i32 %3
}

; Function Attrs: nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  %call = call i64 (...) @read()
  %conv = trunc i64 %call to i32
  %call1 = call i64 (...) @read()
  %conv2 = trunc i64 %call1 to i32
  %conv3 = sext i32 %conv to i64
  %mul = mul i64 8, %conv3
  %call4 = call ptr @malloc_upto_8(i64 noundef %mul)
  store ptr %call4, ptr @v, align 8
  br label %for.cond

for.cond:                                         ; preds = %for.inc20, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc21, %for.inc20 ]
  %cmp = icmp slt i32 %i.0, %conv
  br i1 %cmp, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond
  br label %for.end22

for.body:                                         ; preds = %for.cond
  %conv6 = sext i32 %conv2 to i64
  %mul7 = mul i64 4, %conv6
  %call8 = call ptr @malloc_upto_8(i64 noundef %mul7)
  %0 = load ptr, ptr @v, align 8
  %idxprom = sext i32 %i.0 to i64
  %arrayidx = getelementptr inbounds ptr, ptr %0, i64 %idxprom
  store ptr %call8, ptr %arrayidx, align 8
  br label %for.cond9

for.cond9:                                        ; preds = %for.inc, %for.body
  %j.0 = phi i32 [ 0, %for.body ], [ %inc, %for.inc ]
  %cmp10 = icmp slt i32 %j.0, %conv2
  br i1 %cmp10, label %for.body13, label %for.cond.cleanup12

for.cond.cleanup12:                               ; preds = %for.cond9
  br label %for.end

for.body13:                                       ; preds = %for.cond9
  %call14 = call i64 (...) @read()
  %conv15 = trunc i64 %call14 to i32
  %1 = load ptr, ptr @v, align 8
  %idxprom16 = sext i32 %i.0 to i64
  %arrayidx17 = getelementptr inbounds ptr, ptr %1, i64 %idxprom16
  %2 = load ptr, ptr %arrayidx17, align 8
  %idxprom18 = sext i32 %j.0 to i64
  %arrayidx19 = getelementptr inbounds i32, ptr %2, i64 %idxprom18
  store i32 %conv15, ptr %arrayidx19, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body13
  %inc = add nsw i32 %j.0, 1
  br label %for.cond9, !llvm.loop !8

for.end:                                          ; preds = %for.cond.cleanup12
  br label %for.inc20

for.inc20:                                        ; preds = %for.end
  %inc21 = add nsw i32 %i.0, 1
  br label %for.cond, !llvm.loop !9

for.end22:                                        ; preds = %for.cond.cleanup
  %call23 = call i64 (...) @read()
  %conv24 = trunc i64 %call23 to i32
  br label %while.cond

while.cond:                                       ; preds = %for.end44, %for.end22
  %Q.0 = phi i32 [ %conv24, %for.end22 ], [ %dec, %for.end44 ]
  %dec = add nsw i32 %Q.0, -1
  %tobool = icmp ne i32 %Q.0, 0
  br i1 %tobool, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %call25 = call i64 (...) @read()
  %conv26 = trunc i64 %call25 to i32
  %call27 = call i64 (...) @read()
  %conv28 = trunc i64 %call27 to i32
  %call29 = call i64 (...) @read()
  %conv30 = trunc i64 %call29 to i32
  %call31 = call i64 (...) @read()
  %conv32 = trunc i64 %call31 to i32
  %call33 = call i32 @min_at_row(i32 noundef %conv26, i32 noundef %conv30, i32 noundef %conv32)
  %add = add nsw i32 %conv26, 1
  br label %for.cond35

for.cond35:                                       ; preds = %for.inc42, %while.body
  %res.0 = phi i32 [ %call33, %while.body ], [ %call41, %for.inc42 ]
  %i34.0 = phi i32 [ %add, %while.body ], [ %inc43, %for.inc42 ]
  %cmp36 = icmp sle i32 %i34.0, %conv28
  br i1 %cmp36, label %for.body39, label %for.cond.cleanup38

for.cond.cleanup38:                               ; preds = %for.cond35
  br label %for.end44

for.body39:                                       ; preds = %for.cond35
  %call40 = call i32 @min_at_row(i32 noundef %i34.0, i32 noundef %conv30, i32 noundef %conv32)
  %call41 = call i32 @min(i32 noundef %res.0, i32 noundef %call40)
  br label %for.inc42

for.inc42:                                        ; preds = %for.body39
  %inc43 = add nsw i32 %i34.0, 1
  br label %for.cond35, !llvm.loop !10

for.end44:                                        ; preds = %for.cond.cleanup38
  %conv45 = sext i32 %res.0 to i64
  call void @write(i64 noundef %conv45)
  br label %while.cond, !llvm.loop !11

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
