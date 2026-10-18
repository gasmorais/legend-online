package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.GuildFBPveRankDropTempInfo;
   
   public class GuildFBPveRankDropTempCate extends TemplateCate
   {
      
      private var _tempDroplist:Array;
      
      private var _rankDic:Dictionary;
      
      private var _tempXml:XML;
      
      public function GuildFBPveRankDropTempCate(param1:XMLList)
      {
         super(param1);
         _tempDroplist = [];
         initTemplates();
      }
      
      public function initTemplates() : void
      {
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _tempDroplist.push(createNode(_loc1_,GuildFBPveRankDropTempInfo,_tempXml) as GuildFBPveRankDropTempInfo);
            }
         }
         _list = null;
      }
      
      public function getTempInfoByRank() : Dictionary
      {
         var _loc1_:Array = null;
         _rankDic = new Dictionary();
         for each(var _loc2_:GuildFBPveRankDropTempInfo in _tempDroplist)
         {
            _loc1_ = _rankDic[_loc2_.para2 + ""];
            if(_rankDic[_loc2_.para2])
            {
               _loc1_.push(_loc2_);
            }
            else
            {
               _loc1_ = [];
               _loc1_.push(_loc2_);
            }
            _loc1_.sort(sortById);
            _rankDic[_loc2_.para2] = _loc1_;
         }
         return _rankDic;
      }
      
      private function sortById(param1:GuildFBPveRankDropTempInfo, param2:GuildFBPveRankDropTempInfo) : int
      {
         if(param1.id < param2.id)
         {
            return -1;
         }
         if(param1.id == param2.id)
         {
            return 0;
         }
         if(param1.id > param2.id)
         {
            return 1;
         }
         return 0;
      }
   }
}

