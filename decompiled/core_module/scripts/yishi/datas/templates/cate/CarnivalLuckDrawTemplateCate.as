package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.CarnivalLuckDrawTemplateInfo;
   
   public class CarnivalLuckDrawTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      private var _isInit:Boolean;
      
      private var _findDic:Dictionary;
      
      public function CarnivalLuckDrawTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         _findDic = new Dictionary();
      }
      
      public function initTemplates() : void
      {
         var _loc2_:String = null;
         _isInit = true;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = "" + _loc1_.@Id;
               _dic[_loc2_] = createNode(_loc1_,CarnivalLuckDrawTemplateInfo,_tempXml) as CarnivalLuckDrawTemplateInfo;
            }
         }
         _list = null;
      }
      
      public function getTempInfo(param1:int) : CarnivalLuckDrawTemplateInfo
      {
         if(!_isInit)
         {
            initTemplates();
         }
         var _loc2_:String = "" + param1;
         return _dic[_loc2_];
      }
      
      public function getTempList(param1:int, param2:int = 0) : Array
      {
         if(!_isInit)
         {
            initTemplates();
         }
         var _loc4_:String = param1 + "_" + param2;
         if(_findDic[_loc4_])
         {
            return _findDic[_loc4_];
         }
         var _loc3_:Array = [];
         _findDic[_loc4_] = _loc3_;
         for each(var _loc5_:CarnivalLuckDrawTemplateInfo in _dic)
         {
            if(_loc5_.MasterType == param1 && _loc5_.SonType == param2)
            {
               _loc3_.push(_loc5_);
            }
         }
         _loc3_.sortOn("Id",16);
         return _loc3_;
      }
   }
}

