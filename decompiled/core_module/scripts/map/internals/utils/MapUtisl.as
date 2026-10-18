package map.internals.utils
{
   import com.pickgliss.utils.StringUtils;
   
   public class MapUtisl
   {
      
      private static var _instanceId:int;
      
      public static var sizeMax:Object = {
         "1":{
            "x":-89,
            "y":-145,
            "width":178,
            "height":200,
            "size":1,
            "sizeType":1
         },
         "2":{
            "x":-185,
            "y":-264,
            "width":370,
            "height":339,
            "size":3,
            "sizeType":2
         },
         "3":{
            "x":-130,
            "y":-205,
            "width":260,
            "height":250,
            "size":2,
            "sizeType":3
         },
         "4":{
            "x":-200,
            "y":-200,
            "width":400,
            "height":400,
            "size":4,
            "sizeType":4
         },
         "5":{
            "x":-250,
            "y":-292,
            "width":500,
            "height":417,
            "size":5,
            "sizeType":5
         },
         "6":{
            "x":-240,
            "y":-270,
            "width":450,
            "height":400,
            "size":6,
            "sizeType":6
         },
         "10":{
            "x":-377,
            "y":-650,
            "width":800,
            "height":1000,
            "size":7,
            "sizeType":10
         }
      };
      
      public function MapUtisl()
      {
         super();
      }
      
      public static function getPackageName(param1:String) : String
      {
         param1 = param1.toLowerCase();
         var _loc3_:String = StringUtils.substrLastFolder(param1);
         var _loc2_:String = StringUtils.substrBswfName(param1);
         return "asset." + _loc3_ + "_" + _loc2_ + ".";
      }
      
      public static function get instanceId() : int
      {
         return _instanceId++;
      }
   }
}

