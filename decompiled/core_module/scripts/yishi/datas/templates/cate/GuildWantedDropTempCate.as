package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.CommonDropTempInfo;
   import yishi.utils.SimpleDictionary;
   
   public class GuildWantedDropTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function GuildWantedDropTempCate(param1:XMLList)
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
               _loc2_ = _loc1_.@id;
               if(!_dic[_loc2_])
               {
                  _dic[_loc2_] = createNode(_loc1_,CommonDropTempInfo,_tempXml);
               }
            }
         }
         _list = null;
         return _dic;
      }
      
      public function getDropsByTypeIndex(param1:int, param2:String) : Array
      {
         var _loc3_:Array = [];
         for each(var _loc4_:CommonDropTempInfo in _dic)
         {
            if(_loc4_.site == param1 && _loc4_.para2 == param2)
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_;
      }
      
      public function getRewardList(param1:int) : SimpleDictionary
      {
         var _loc2_:Array = null;
         var _loc5_:String = null;
         var _loc4_:SimpleDictionary = new SimpleDictionary();
         for each(var _loc3_:CommonDropTempInfo in _dic)
         {
            if(_loc3_.site == param1)
            {
               _loc5_ = _loc3_.para2;
               if(!_loc4_[_loc5_])
               {
                  _loc4_.add(_loc5_,[]);
               }
               _loc2_ = _loc4_[_loc5_];
               _loc2_.push(_loc3_);
            }
         }
         return _loc4_;
      }
   }
}

