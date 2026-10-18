package mvc.module.goddess
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.GoddessAdvaceTempInfo;
   import yishi.datas.templates.GoddessDedicationTempInfo;
   import yishi.datas.templates.GoddessTempInfo;
   import yishi.datas.templates.GoddessUpLevelTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   
   public class GoddessInfo
   {
      
      private var _grade:int;
      
      private var _gradeGp:int;
      
      private var _step:int = -1;
      
      private var _stepGp:int;
      
      private var _devote:int;
      
      private var _devoteGp:int;
      
      private var _activeSkill:int;
      
      private var _defanceSkill:int;
      
      private var _isFight:Boolean = false;
      
      private var _templateId:int;
      
      private var _type:int;
      
      private var _isActive:Boolean = false;
      
      private var _tempInfo:GoddessTempInfo;
      
      private var _levelTempInfo:GoddessUpLevelTempInfo;
      
      private var _nextLevelTempInfo:GoddessUpLevelTempInfo;
      
      private var _advacneTempInfo:GoddessAdvaceTempInfo;
      
      private var _nextAdvanceTempInfo:GoddessAdvaceTempInfo;
      
      private var _dedicationTempInfo:GoddessDedicationTempInfo;
      
      private var _nextDedicationTempInfo:GoddessDedicationTempInfo;
      
      public var userId:int;
      
      public var attack:int;
      
      public var defance:int;
      
      public var magicAttack:int;
      
      public var magicDefance:int;
      
      public var live:int;
      
      public var initBelief:int;
      
      public var actionBelief:int;
      
      public var equips:Dictionary = new Dictionary();
      
      public function GoddessInfo()
      {
         super();
      }
      
      public function init() : void
      {
         var _loc1_:GoddessEquipInfo = null;
         grade = 1;
         step = 0;
         devote = 1;
         _loc1_ = new GoddessEquipInfo();
         _loc1_.equipType = 1;
         equips[_loc1_.equipType] = _loc1_;
         _loc1_ = new GoddessEquipInfo();
         _loc1_.equipType = 2;
         equips[_loc1_.equipType] = _loc1_;
         _loc1_ = new GoddessEquipInfo();
         _loc1_.equipType = 3;
         equips[_loc1_.equipType] = _loc1_;
         _loc1_ = new GoddessEquipInfo();
         _loc1_.equipType = 4;
         equips[_loc1_.equipType] = _loc1_;
      }
      
      public function getPropertyByIndex(param1:int) : int
      {
         return [0,attack,magicAttack,defance,magicDefance,live][param1];
      }
      
      public function get templateId() : int
      {
         return _templateId;
      }
      
      public function set templateId(param1:int) : void
      {
         if(_templateId == param1)
         {
            return;
         }
         _templateId = param1;
         _tempInfo = TempleteManager.instance.goddessTempCate.getTemplateById(_templateId);
         type = _tempInfo.Type;
      }
      
      public function get tempInfo() : GoddessTempInfo
      {
         return _tempInfo;
      }
      
      public function get levelTempInfo() : GoddessUpLevelTempInfo
      {
         return _levelTempInfo;
      }
      
      public function get nextLevelTempInfo() : GoddessUpLevelTempInfo
      {
         return _nextLevelTempInfo;
      }
      
      public function get advanceTempInfo() : GoddessAdvaceTempInfo
      {
         return _advacneTempInfo;
      }
      
      public function get nextAdvanceTempInfo() : GoddessAdvaceTempInfo
      {
         return _nextAdvanceTempInfo;
      }
      
      public function get dedicationTempInfo() : GoddessDedicationTempInfo
      {
         return _dedicationTempInfo;
      }
      
      public function get nextDedicationTempInfo() : GoddessDedicationTempInfo
      {
         return _nextDedicationTempInfo;
      }
      
      public function get grade() : int
      {
         return _grade;
      }
      
      public function set grade(param1:int) : void
      {
         if(_grade == param1 || _tempInfo == null)
         {
            return;
         }
         _grade = param1;
         _levelTempInfo = TempleteManager.instance.goddessLevelTempCate.getTemplete(_type,_grade);
         _nextLevelTempInfo = TempleteManager.instance.goddessLevelTempCate.getTemplete(_type,_grade + 1);
         MsgMan.notifyObserver("GodDessEvent.level",this);
      }
      
      public function get gradeGp() : int
      {
         return _gradeGp;
      }
      
      public function set gradeGp(param1:int) : void
      {
         if(_gradeGp == param1)
         {
            return;
         }
         _gradeGp = param1;
         MsgMan.notifyObserver("GodDessEvent.expLevel",this);
      }
      
      public function get step() : int
      {
         return _step;
      }
      
      public function set step(param1:int) : void
      {
         if(_step == param1)
         {
            return;
         }
         _step = param1;
         _advacneTempInfo = TempleteManager.instance.goddessAdvanceTempCate.getTemplete(_type,_step);
         _nextAdvanceTempInfo = TempleteManager.instance.goddessAdvanceTempCate.getTemplete(_type,_step + 1);
         MsgMan.notifyObserver("GodDessEvent.step",this);
      }
      
      public function get stepGp() : int
      {
         return _stepGp;
      }
      
      public function set stepGp(param1:int) : void
      {
         if(_stepGp == param1)
         {
            return;
         }
         _stepGp = param1;
         MsgMan.notifyObserver("GodDessEvent.expStep",this);
      }
      
      public function get isFight() : Boolean
      {
         return _isFight;
      }
      
      public function set isFight(param1:Boolean) : void
      {
         if(_isFight == param1)
         {
            return;
         }
         _isFight = param1;
         MsgMan.notifyObserver("GodDessEvent.isFight",this);
      }
      
      public function get activeSkill() : int
      {
         return _activeSkill;
      }
      
      public function set activeSkill(param1:int) : void
      {
         if(_activeSkill == param1)
         {
            return;
         }
         _activeSkill = param1;
         MsgMan.notifyObserver("GodDessEvent.activeSkill",this);
      }
      
      public function get defanceSkill() : int
      {
         return _defanceSkill;
      }
      
      public function set defanceSkill(param1:int) : void
      {
         if(_defanceSkill == param1)
         {
            return;
         }
         _defanceSkill = param1;
         MsgMan.notifyObserver("GodDessEvent.defanceSkill",this);
      }
      
      public function get devote() : int
      {
         return _devote;
      }
      
      public function set devote(param1:int) : void
      {
         if(_devote == param1)
         {
            return;
         }
         _devote = param1;
         _dedicationTempInfo = TempleteManager.instance.goddessDedicationTempCate.getTemplete(_type,_devote);
         _nextDedicationTempInfo = TempleteManager.instance.goddessDedicationTempCate.getTemplete(_type,_devote + 1);
         MsgMan.notifyObserver("GodDessEvent.devote",this);
      }
      
      public function get devoteGp() : int
      {
         return _devoteGp;
      }
      
      public function set devoteGp(param1:int) : void
      {
         if(_devoteGp == param1)
         {
            return;
         }
         _devoteGp = param1;
         MsgMan.notifyObserver("GodDessEvent.expDevote",this);
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
      
      public function get isActive() : Boolean
      {
         return _isActive;
      }
      
      public function set isActive(param1:Boolean) : void
      {
         if(_isActive == param1)
         {
            return;
         }
         _isActive = param1;
         MsgMan.notifyObserver("GodDessEvent.isActive",this);
      }
   }
}

