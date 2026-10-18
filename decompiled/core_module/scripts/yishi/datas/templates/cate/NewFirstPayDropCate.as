package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.NewFirstPayDropInfo;
   
   public class NewFirstPayDropCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function NewFirstPayDropCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         initTemplates();
      }
      
      public function initTemplates() : void
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@id + "";
               _dic[_loc2_] = createNode(_loc1_,NewFirstPayDropInfo,_tempXml) as NewFirstPayDropInfo;
            }
         }
         _list = null;
      }
      
      public function getDropGoods(param1:int, param2:String, param3:String) : Array
      {
         var _loc4_:Array = [];
         for each(var _loc5_:NewFirstPayDropInfo in _dic)
         {
            if(_loc5_.site == param1 && (_loc5_.para2 == param2 || _loc5_.para2 == param3))
            {
               _loc4_.push(_loc5_);
            }
         }
         return _loc4_;
      }
   }
}

