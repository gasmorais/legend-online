package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.GoddessEquipTempInfo;
   
   public class GoddessEquipTempCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      private var _maxStrength:int = -1;
      
      private var _maxStep:int = -1;
      
      public function GoddessEquipTempCate(param1:XMLList)
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
               _loc2_ = _loc1_.@Id + "";
               _dic[_loc2_] = createNode(_loc1_,GoddessEquipTempInfo,_tempXml) as GoddessEquipTempInfo;
            }
         }
         _list = null;
      }
      
      public function getEquipTempInfo(param1:int, param2:int, param3:int) : GoddessEquipTempInfo
      {
         for each(var _loc4_:GoddessEquipTempInfo in _dic)
         {
            if(_loc4_.AdvanceType == param1 && _loc4_.EquipType == param2 && _loc4_.Grade == param3)
            {
               return _loc4_;
            }
         }
         return null;
      }
      
      public function getSuitTempInfo(param1:int, param2:int) : GoddessEquipTempInfo
      {
         for each(var _loc3_:GoddessEquipTempInfo in _dic)
         {
            if(_loc3_.AdvanceType == param1 && _loc3_.EquipType == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function getMaxStrength() : int
      {
         if(_maxStrength > -1)
         {
            return _maxStrength;
         }
         for each(var _loc1_:GoddessEquipTempInfo in _dic)
         {
            if(_loc1_.AdvanceType == 1 && _loc1_.Grade > _maxStrength)
            {
               _maxStrength = _loc1_.Grade;
            }
         }
         return _maxStrength;
      }
      
      public function getMaxStep() : int
      {
         if(_maxStep > -1)
         {
            return _maxStep;
         }
         for each(var _loc1_:GoddessEquipTempInfo in _dic)
         {
            if(_loc1_.AdvanceType == 2 && _loc1_.Grade > _maxStep)
            {
               _maxStep = _loc1_.Grade;
            }
         }
         return _maxStep;
      }
   }
}

