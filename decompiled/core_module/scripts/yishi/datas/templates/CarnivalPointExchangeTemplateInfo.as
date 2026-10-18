package yishi.datas.templates
{
   import bag.helper.GoodsCheck;
   import yishi.manager.TempleteManager;
   
   public class CarnivalPointExchangeTemplateInfo
   {
      
      public static const GOODS:int = 1;
      
      public static const FASHION:int = 2;
      
      public static const MOUNTS:int = 3;
      
      public static const PET:int = 4;
      
      public var Id:int;
      
      public var Type:int;
      
      public var Sort:int;
      
      public var Target:int;
      
      public var Price:int;
      
      public var ItemNum1:int;
      
      public var Item2:int;
      
      public var ItemNum2:int;
      
      public var Item3:int;
      
      public var ItemNum3:int;
      
      public var Item4:int;
      
      public var ItemNum4:int;
      
      private var _Item1:int;
      
      private var _specialType:int = 1;
      
      public function CarnivalPointExchangeTemplateInfo()
      {
         super();
      }
      
      public function get specialType() : int
      {
         return _specialType;
      }
      
      public function get Item1() : int
      {
         return _Item1;
      }
      
      public function set Item1(param1:int) : void
      {
         _Item1 = param1;
         var _loc2_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(Item1);
         if(_loc2_)
         {
            if(GoodsCheck.isFashion(_loc2_))
            {
               _specialType = 2;
            }
            else if(GoodsCheck.isMount(_loc2_))
            {
               _specialType = 3;
            }
            else if(GoodsCheck.isPet(_loc2_))
            {
               _specialType = 4;
            }
         }
      }
   }
}

