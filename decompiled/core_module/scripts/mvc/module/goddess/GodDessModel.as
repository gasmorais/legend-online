package mvc.module.goddess
{
   import yishi.datas.templates.GoddessTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.HashMap;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleDictionary;
   
   public class GodDessModel
   {
      
      private var _infoDic:SimpleDictionary;
      
      private var _selectInfo:GoddessInfo = null;
      
      private var _equipSelectInfo:GoddessEquipInfo = null;
      
      public var doubleOpen:Boolean;
      
      public var doubleOpenString:String;
      
      public var doubleEndString:String;
      
      public var fightGoddess:GoddessInfo = null;
      
      public var selectedArrayIndex:int;
      
      private var _formationMap:HashMap;
      
      public function GodDessModel()
      {
         super();
         initInfos();
      }
      
      public function initInfos() : void
      {
         var _loc3_:GoddessInfo = null;
         _infoDic = new SimpleDictionary();
         var _loc2_:Array = TempleteManager.instance.goddessTempCate.getTemplates();
         for each(var _loc1_:GoddessTempInfo in _loc2_)
         {
            _loc3_ = new GoddessInfo();
            _loc3_.templateId = _loc1_.TemplateId;
            _loc3_.type = _loc1_.Type;
            _loc3_.init();
            _infoDic.add(_loc3_.templateId,_loc3_);
         }
         _formationMap = new HashMap();
      }
      
      public function get infoDic() : SimpleDictionary
      {
         return _infoDic;
      }
      
      public function get sortInfos() : Array
      {
         var _loc1_:Array = _infoDic.getList();
         _loc1_.sort(compareFun);
         return _loc1_;
      }
      
      private function compareFun(param1:GoddessInfo, param2:GoddessInfo) : int
      {
         var _loc4_:int = param1.advanceTempInfo.Quality;
         var _loc3_:int = param2.advanceTempInfo.Quality;
         if(param1.isActive != param2.isActive && param1.isActive)
         {
            return -1;
         }
         if(param1.isActive == param2.isActive)
         {
            if(_loc4_ > _loc3_)
            {
               return -1;
            }
            if(_loc4_ == _loc3_)
            {
               if(param1.grade > param2.grade)
               {
                  return -1;
               }
               if(param1.grade == param2.grade)
               {
                  if(param1.templateId > param2.templateId)
                  {
                     return -1;
                  }
                  if(param1.templateId == param2.templateId)
                  {
                     return 0;
                  }
                  return 1;
               }
               return 1;
            }
            return 1;
         }
         return 1;
      }
      
      public function get selectInfo() : GoddessInfo
      {
         return _selectInfo;
      }
      
      public function set selectInfo(param1:GoddessInfo) : void
      {
         if(_selectInfo == param1)
         {
            return;
         }
         _selectInfo = param1;
         MsgMan.notifyObserver("GodDessEvent.choose",_selectInfo);
      }
      
      public function get formationMap() : HashMap
      {
         return _formationMap;
      }
      
      public function set formationMap(param1:HashMap) : void
      {
         _formationMap = param1;
      }
      
      public function get equipSelectInfo() : GoddessEquipInfo
      {
         return _equipSelectInfo;
      }
      
      public function set equipSelectInfo(param1:GoddessEquipInfo) : void
      {
         _equipSelectInfo = param1;
      }
   }
}

