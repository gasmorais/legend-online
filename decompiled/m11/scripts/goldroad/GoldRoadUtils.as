package goldroad
{
   import flash.filters.ColorMatrixFilter;
   
   public class GoldRoadUtils
   {
      
      public function GoldRoadUtils()
      {
         super();
      }
      
      public static function getFilterByNum(param1:int) : ColorMatrixFilter
      {
         switch(param1)
         {
            case 8:
               return new ColorMatrixFilter([-0.13,0.14,1,0,36,0.39,0.8,-0.19,0,36,-0.53,1.54,-0.02,0,36,0,0,0,1,0]);
            case 26:
               return new ColorMatrixFilter([0.29,1.54,-0.83,0,30,0.11,0.53,0.36,0,30,1.03,0.14,-0.16,0,30,0,0,0,1,0]);
            case 35:
               return new ColorMatrixFilter([0.68,-0.29,0.61,0,32,0.14,1.02,-0.17,0,32,-0.46,0.63,0.83,0,32,0,0,0,1,0]);
            default:
               return null;
         }
      }
      
      public static function getVertexByStep(param1:int) : String
      {
         switch(param1)
         {
            case 0:
               return "GoldRoadCell.vertexImage0";
            case 9:
               return "GoldRoadCell.vertexImage9";
            case 18:
               return "GoldRoadCell.vertexImage18";
            case 27:
               return "GoldRoadCell.vertexImage27";
            default:
               return "";
         }
      }
   }
}

