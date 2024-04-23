; ModuleID = '.tmp/a.ll'
source_filename = "collatz/src/collatz.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define dso_local i32 @collatz(ptr noundef %iter, i32 noundef %n) #0 {
entry:
  %conv = zext i32 %n to i64
  call void @write(i64 noundef %conv)
  %cmp = icmp ule i32 %n, 1
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  br label %return

if.end:                                           ; preds = %entry
  %0 = load i16, ptr %iter, align 2
  %conv2 = sext i16 %0 to i32
  %cmp3 = icmp slt i32 %conv2, 0
  br i1 %cmp3, label %if.then5, label %if.end6

if.then5:                                         ; preds = %if.end
  br label %return

if.end6:                                          ; preds = %if.end
  %1 = load i16, ptr %iter, align 2
  %conv7 = sext i16 %1 to i32
  %add = add nsw i32 %conv7, 1
  %conv8 = trunc i32 %add to i16
  store i16 %conv8, ptr %iter, align 2
  %rem = urem i32 %n, 2
  %cmp9 = icmp eq i32 %rem, 0
  br i1 %cmp9, label %cond.true, label %cond.false

cond.true:                                        ; preds = %if.end6
  %div = udiv i32 %n, 2
  br label %cond.end

cond.false:                                       ; preds = %if.end6
  %mul = mul i32 3, %n
  %add11 = add i32 %mul, 1
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %div, %cond.true ], [ %add11, %cond.false ]
  %call = call i32 @collatz(ptr noundef %iter, i32 noundef %cond)
  br label %return

return:                                           ; preds = %cond.end, %if.then5, %if.then
  %retval.0 = phi i32 [ %n, %if.then ], [ -1, %if.then5 ], [ %call, %cond.end ]
  ret i32 %retval.0
}

declare void @write(i64 noundef) #1

; Function Attrs: nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  %iter = alloca i16, align 2
  %call = call i64 (...) @read()
  %conv = trunc i64 %call to i32
  store i16 0, ptr %iter, align 2
  %call1 = call i32 @collatz(ptr noundef %iter, i32 noundef %conv)
  %0 = load i16, ptr %iter, align 2
  %conv2 = sext i16 %0 to i64
  call void @write(i64 noundef %conv2)
  ret i32 0
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #2

declare i64 @read(...) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #2

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"clang version 18.1.0rc (https://github.com/llvm/llvm-project.git 461274b81d8641eab64d494accddc81d7db8a09e)"}
