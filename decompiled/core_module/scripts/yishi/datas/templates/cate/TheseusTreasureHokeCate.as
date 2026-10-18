package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.TheseusTreasureHokeInfo;
   
   public class TheseusTreasureHokeCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function TheseusTreasureHokeCate(param1:XMLList)
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
               _loc2_ = _loc1_.@TemplateId + "";
               _dic[_loc2_] = createNode(_loc1_,TheseusTreasureHokeInfo,_tempXml) as TheseusTreasureHokeInfo;
            }
         }
         _list = null;
      }
      
      public function getTempInfoByHokeId(param1:int, param2:int = 1) : TheseusTreasureHokeInfo
      {
         var _loc3_:TheseusTreasureHokeInfo = null;
         for each(var _loc4_:TheseusTreasureHokeInfo in _dic)
         {
            if(_loc4_.HokeId == param1 && _loc4_.Type == param2)
            {
               _loc3_ = _loc4_;
               break;
            }
         }
         return _loc3_;
      }
   }
}

