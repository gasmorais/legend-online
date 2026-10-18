package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.GuildFBDropTempInfo;
   
   public class GuildFBDropTempCate extends TemplateCate
   {
      
      private var _findDic:Dictionary;
      
      private var _tempDroplist:Array;
      
      private var _tempXml:XML;
      
      public function GuildFBDropTempCate(param1:XMLList)
      {
         super(param1);
         _tempDroplist = [];
         _findDic = new Dictionary();
         initTemplates();
      }
      
      public function initTemplates() : void
      {
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _tempDroplist.push(createNode(_loc1_,GuildFBDropTempInfo,_tempXml) as GuildFBDropTempInfo);
            }
         }
         _list = null;
      }
      
      public function getTempInfos(param1:int) : Array
      {
         var _loc2_:Array = _findDic[param1 + ""];
         if(_loc2_ != null)
         {
            return _loc2_;
         }
         _loc2_ = [];
         _findDic[param1 + ""] = _loc2_;
         for each(var _loc3_:GuildFBDropTempInfo in _tempDroplist)
         {
            if(_loc3_.DropId == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
   }
}

