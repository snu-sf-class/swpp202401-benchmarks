; ModuleID = '.tmp/a.ll'
source_filename = "bitcount5.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@num_to_bits = external global [16 x i32], align 16

; Function Attrs: nounwind uwtable
define dso_local i32 @countSetBitsRec(i32 noundef %num) #0 {
entry:
  %cmp = icmp eq i32 0, %num
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %0 = load i32, ptr @num_to_bits, align 16
  br label %cleanup

if.end:                                           ; preds = %entry
  %and = and i32 %num, 15
  %idxprom = sext i32 %and to i64
  %arrayidx = getelementptr inbounds [16 x i32], ptr @num_to_bits, i64 0, i64 %idxprom
  %1 = load i32, ptr %arrayidx, align 4
  %shr = lshr i32 %num, 4
  %call = call i32 @countSetBitsRec(i32 noundef %shr)
  %add = add i32 %1, %call
  br label %cleanup

cleanup:                                          ; preds = %if.end, %if.then
  %retval.0 = phi i32 [ %0, %if.then ], [ %add, %if.end ]
  ret i32 %retval.0
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  store i32 0, ptr @num_to_bits, align 16
  store i32 1, ptr getelementptr inbounds ([16 x i32], ptr @num_to_bits, i64 0, i64 1), align 4
  store i32 1, ptr getelementptr inbounds ([16 x i32], ptr @num_to_bits, i64 0, i64 2), align 8
  store i32 2, ptr getelementptr inbounds ([16 x i32], ptr @num_to_bits, i64 0, i64 3), align 4
  store i32 1, ptr getelementptr inbounds ([16 x i32], ptr @num_to_bits, i64 0, i64 4), align 16
  store i32 2, ptr getelementptr inbounds ([16 x i32], ptr @num_to_bits, i64 0, i64 5), align 4
  store i32 2, ptr getelementptr inbounds ([16 x i32], ptr @num_to_bits, i64 0, i64 6), align 8
  store i32 3, ptr getelementptr inbounds ([16 x i32], ptr @num_to_bits, i64 0, i64 7), align 4
  store i32 1, ptr getelementptr inbounds ([16 x i32], ptr @num_to_bits, i64 0, i64 8), align 16
  store i32 2, ptr getelementptr inbounds ([16 x i32], ptr @num_to_bits, i64 0, i64 9), align 4
  store i32 2, ptr getelementptr inbounds ([16 x i32], ptr @num_to_bits, i64 0, i64 10), align 8
  store i32 3, ptr getelementptr inbounds ([16 x i32], ptr @num_to_bits, i64 0, i64 11), align 4
  store i32 2, ptr getelementptr inbounds ([16 x i32], ptr @num_to_bits, i64 0, i64 12), align 16
  store i32 3, ptr getelementptr inbounds ([16 x i32], ptr @num_to_bits, i64 0, i64 13), align 4
  store i32 3, ptr getelementptr inbounds ([16 x i32], ptr @num_to_bits, i64 0, i64 14), align 8
  store i32 4, ptr getelementptr inbounds ([16 x i32], ptr @num_to_bits, i64 0, i64 15), align 4
  %call = call i64 (...) @read()
  %conv = trunc i64 %call to i32
  %call1 = call i32 @countSetBitsRec(i32 noundef %conv)
  %conv2 = zext i32 %call1 to i64
  call void @write(i64 noundef %conv2)
  ret i32 0
}

declare void @write(i64 noundef) #2

declare i64 @read(...) #2

attributes #0 = { nounwind uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"clang version 18.1.0rc (https://github.com/llvm/llvm-project.git 461274b81d8641eab64d494accddc81d7db8a09e)"}
