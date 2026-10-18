package mvc.module.singlepass
{
   public class SinglePassCardStateInfo
   {
      
      public static const LEFT:String = "left";
      
      public static const CENTER:String = "center";
      
      public static const RIGHT:String = "right";
      
      public var alpha:Number;
      
      public var x:Number;
      
      public var y:Number;
      
      public var scale:Number;
      
      public var align:String;
      
      public function SinglePassCardStateInfo(param1:Number, param2:Number, param3:Number, param4:Number, param5:String)
      {
         super();
         this.alpha = param1;
         this.x = param2;
         this.y = param3;
         this.scale = param4;
         this.align = param5;
      }
   }
}

