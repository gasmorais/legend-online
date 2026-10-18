package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.TheseusEquipSuiteTempInfo;
   
   public class TheseusEquipSuiteTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      private var _sontypeDic:Dictionary = new Dictionary();
      
      public function TheseusEquipSuiteTempCate(param1:XMLList)
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
               _dic[_loc2_] = createNode(_loc1_,TheseusEquipSuiteTempInfo,_tempXml) as TheseusEquipSuiteTempInfo;
            }
         }
         _list = null;
      }
      
      public function getTempInfo(param1:int, param2:int, param3:int) : Array
      {
         var _loc5_:TheseusEquipSuiteTempInfo = null;
         var _loc8_:TheseusEquipSuiteTempInfo = null;
         var _loc7_:int = 0;
         var _loc4_:Array = [];
         var _loc6_:String = param1 + "_" + param2;
         if(!_sontypeDic[_loc6_])
         {
            for each(var _loc9_:TheseusEquipSuiteTempInfo in _dic)
            {
               if(_loc9_.NeedIndex == param1 && _loc9_.NeedPart == param2)
               {
                  _loc4_.push(_loc9_);
               }
            }
            _loc4_.sortOn("NeedMinLevel",16);
            _sontypeDic[_loc6_] = _loc4_;
         }
         else
         {
            _loc4_ = _sontypeDic[_loc6_];
         }
         _loc7_ = 0;
         while(_loc7_ < _loc4_.length)
         {
            _loc5_ = _loc4_[_loc7_];
            if(_loc5_.NeedMinLevel > param3)
            {
               break;
            }
            _loc8_ = _loc5_;
            _loc7_++;
         }
         return [_loc8_,_loc5_];
      }
   }
}

