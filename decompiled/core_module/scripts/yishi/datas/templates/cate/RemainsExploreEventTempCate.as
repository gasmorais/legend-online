package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.RemainsExploreEventTempInfo;
   import yishi.manager.RemainsExploreManager;
   import yishi.utils.SimpleDictionary;
   
   public class RemainsExploreEventTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function RemainsExploreEventTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
         getTemplates();
      }
      
      public function getTemplates() : Dictionary
      {
         var _loc2_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc2_ = _loc1_.@EventId;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,RemainsExploreEventTempInfo,_tempXml);
               }
            }
         }
         return _dic;
      }
      
      public function getDrop(param1:int) : SimpleDictionary
      {
         var _loc2_:SimpleDictionary = new SimpleDictionary();
         var _loc3_:SimpleDictionary = new SimpleDictionary();
         for each(var _loc4_:RemainsExploreEventTempInfo in _dic)
         {
            if(_loc4_.EventGroup != param1)
            {
               continue;
            }
            switch(_loc4_.EventType)
            {
               case RemainsExploreManager.EVENT_BOSS1:
                  _loc2_.add(1,int(_loc4_.Param4));
                  break;
               case RemainsExploreManager.EVENT_BOSS2:
                  _loc2_.add(2,int(_loc4_.Param4));
                  break;
               default:
                  _loc3_.add(int(_loc4_.Param4),int(_loc4_.Param4));
            }
         }
         _loc2_.add(3,_loc3_.getList());
         return _loc2_;
      }
   }
}

