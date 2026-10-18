package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.CatHouseTemplateInfo;
   
   public class CatHouseTemplateCate extends TemplateCate
   {
      
      public static const SHELF_TOY_TYPE:int = 101;
      
      public static const PAD_TOY_TYPE:int = 102;
      
      public static const STICK_TOY_TYPE:int = 103;
      
      public static const BALL_TOY_TYPE:int = 104;
      
      public static const BOX_TOY_TYPE:int = 105;
      
      public static const INDEX_TO_TYPE:Array = [102,105,101,103,104];
      
      private var _dic:Dictionary;
      
      private var _typeListDic:Dictionary;
      
      private var _isFirst:Boolean;
      
      public function CatHouseTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         _typeListDic = new Dictionary();
      }
      
      public function getTemplateById(param1:int) : CatHouseTemplateInfo
      {
         checkFirst();
         var _loc2_:CatHouseTemplateInfo = _dic[param1];
         if(_loc2_ == null)
         {
            _loc2_ = new CatHouseTemplateInfo();
            _loc2_.TemplateName = "empty";
         }
         return _loc2_;
      }
      
      public function getTemplatesByType(param1:int) : Vector.<CatHouseTemplateInfo>
      {
         checkFirst();
         return _typeListDic[param1];
      }
      
      override protected function checkFirst() : void
      {
         var _loc4_:CatHouseTemplateInfo = null;
         var _loc5_:* = undefined;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(_isFirst)
         {
            return;
         }
         if(_list != null)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc3_ = int(_loc1_.@TemplateId);
               _loc4_ = createNode(_loc1_,CatHouseTemplateInfo) as CatHouseTemplateInfo;
               _dic[_loc3_] = _loc4_;
               _loc2_ = int(_loc1_.@Types);
               _loc5_ = _typeListDic[_loc2_];
               if(_loc5_ == null)
               {
                  _loc5_ = new Vector.<CatHouseTemplateInfo>();
                  _typeListDic[_loc2_] = _loc5_;
               }
               _loc5_.push(_loc4_);
            }
            _isFirst = true;
         }
      }
   }
}

