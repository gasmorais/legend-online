package map.campaign.view.ui.monopoly
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import events.PetEvent;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import managers.MonopolySocketOutManager;
   import map.campaign.CampaignManager;
   import mvc.module.pet.PetData;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.utils.IconFactory;
   import yishi.utils.WorldBossHelper;
   import yishi.view.community.BaseIconView;
   
   public class MonopolyTeamItemView extends Component
   {
      
      private var _headBack:Image;
      
      private var _headIcon:BaseIconView;
      
      private var _skillList:Vector.<MonopolySkillView>;
      
      private var _arrmor01:Bitmap;
      
      private var _arrmor02:Bitmap;
      
      private var _currentSelectedItem:MonopolySkillView;
      
      private var _selectSkillView:MonopolySkillSelectView;
      
      private var _data:PetData;
      
      public function MonopolyTeamItemView()
      {
         super();
         initView();
         addEvent();
         this.mouseEnabled = false;
      }
      
      private function initView() : void
      {
         var _loc1_:MonopolySkillView = null;
         var _loc2_:int = 0;
         _headBack = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyTeamItemView.headBack");
         _headIcon = ComponentFactory.Instance.creatCustomObject("monopoly.MonopolyTeamItemView.headIcon");
         _arrmor01 = ComponentFactory.Instance.creatBitmap("asset.monopoly.ArrmorImg");
         _arrmor02 = ComponentFactory.Instance.creatBitmap("asset.monopoly.ArrmorImg");
         _arrmor01.x = 89;
         _arrmor01.y = 15;
         _arrmor02.x = 139;
         _arrmor02.y = 15;
         addChild(_headBack);
         addChild(_headIcon);
         addChild(_arrmor01);
         addChild(_arrmor02);
         _skillList = new Vector.<MonopolySkillView>(3);
         _loc2_ = 0;
         while(_loc2_ < _skillList.length)
         {
            _loc1_ = new MonopolySkillView(_loc2_);
            _loc1_.tipStyle = "yishi.view.tips.goods.SkillTips";
            _loc1_.tipDirctions = "4,1,6,5,2,7,0,3";
            _loc1_.isFollowMouse = false;
            _loc1_.x = 55 + _loc2_ * 50;
            _loc1_.y = 5;
            addChild(_loc1_);
            _skillList[_loc2_] = _loc1_;
            _loc2_++;
         }
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_headBack);
         _headBack = null;
         ObjectUtils.disposeObject(_headIcon);
         _headIcon = null;
         ObjectUtils.disposeObject(_arrmor01);
         _arrmor01 = null;
         ObjectUtils.disposeObject(_arrmor02);
         _arrmor02 = null;
         ObjectUtils.disposeObject(_selectSkillView);
         _selectSkillView = null;
         ObjectUtils.disposeAllChildren(this);
         _skillList = null;
      }
      
      private function addEvent() : void
      {
         if(_data)
         {
            _data.addEventListener("PET_CHALLENGE_SKILL_CHANGE",__skillChangeHandler);
            this.addEventListener("mouseDown",__mouseClickHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_data)
         {
            _data.removeEventListener("PET_CHALLENGE_SKILL_CHANGE",__skillChangeHandler);
            this.removeEventListener("mouseDown",__mouseClickHandler);
         }
      }
      
      private function __skillChangeHandler(param1:PetEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Array = skillList;
         _loc2_ = 0;
         while(_loc2_ < _skillList.length)
         {
            if(_loc3_.length > _loc2_)
            {
               _skillList[_loc2_].data = _loc3_[_loc2_] as SkillTempInfo;
            }
            else
            {
               _skillList[_loc2_].data = null;
            }
            _loc2_++;
         }
         _loc3_ = null;
      }
      
      private function __mouseClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         if(!data)
         {
            return;
         }
         if(_currentSelectedItem == param1.target && _selectSkillView && !_selectSkillView.isDie)
         {
            _selectSkillView.dispose();
            _selectSkillView = null;
            return;
         }
         _currentSelectedItem = null;
         if(param1.target is MonopolySkillView)
         {
            _currentSelectedItem = param1.target as MonopolySkillView;
         }
         if(_currentSelectedItem)
         {
            _selectSkillView = new MonopolySkillSelectView();
            _selectSkillView.show(data.activeSkillList,selectSkill);
            _loc2_ = new Point(_currentSelectedItem.displayWidth / 2,_currentSelectedItem.y);
            _loc2_ = _currentSelectedItem.localToGlobal(_loc2_);
            _selectSkillView.x = _loc2_.x - _selectSkillView.displayWidth / 2;
            _selectSkillView.y = _loc2_.y - _selectSkillView.displayHeight - 5;
            if(_selectSkillView.x + _selectSkillView.displayWidth > StageReferance.stageWidth)
            {
               _selectSkillView.x = StageReferance.stageWidth - _selectSkillView.displayWidth;
            }
         }
         param1.stopPropagation();
      }
      
      private function selectSkill(param1:SkillTempInfo) : void
      {
         var _loc5_:SkillTempInfo = null;
         if(!data)
         {
            _currentSelectedItem = null;
            return;
         }
         var _loc2_:Array = skillList;
         var _loc6_:int = 0;
         var _loc3_:* = -1;
         for each(_loc5_ in _loc2_)
         {
            if(_loc5_ && _loc5_.TemplateId == param1.TemplateId)
            {
               _loc3_ = _loc6_;
               break;
            }
            _loc6_++;
         }
         if(_currentSelectedItem)
         {
            if(_loc3_ >= 0)
            {
               _loc2_[_loc3_] = _currentSelectedItem.data;
            }
            _currentSelectedItem.data = param1;
            _loc2_[_currentSelectedItem.index] = param1;
            _currentSelectedItem = null;
         }
         var _loc7_:Array = [];
         for each(_loc5_ in _loc2_)
         {
            _loc6_ = int(_data.changeSkillTemplates.indexOf(_loc5_));
            _loc7_.push(_loc6_);
            _loc5_ = null;
         }
         var _loc4_:String = _loc7_.join(",");
         if(skillStr != _loc4_)
         {
            skillStr = _loc4_;
            MonopolySocketOutManager.sendPetSkills(_data.petId,_loc4_);
         }
         _selectSkillView = null;
      }
      
      public function get data() : PetData
      {
         return _data;
      }
      
      public function set data(param1:PetData) : void
      {
         if(_data == param1)
         {
            return;
         }
         removeEvent();
         clean();
         _data = param1;
         if(_data)
         {
            refresh();
            addEvent();
         }
      }
      
      private function refresh() : void
      {
         _headIcon.tipData = _data;
         _headIcon.icon = IconFactory.getPetHeadItemIcon(_data.templateId);
         __skillChangeHandler(null);
      }
      
      private function clean() : void
      {
         var _loc1_:int = 0;
         _headIcon.icon = null;
         _headIcon.tipData = null;
         _loc1_ = 0;
         while(_loc1_ < _skillList.length)
         {
            _skillList[_loc1_].data = null;
            _loc1_++;
         }
      }
      
      private function get skillList() : Array
      {
         if(!_data)
         {
            return [null,null,null];
         }
         var _loc1_:int = int(CampaignManager.instance.mapId);
         if(WorldBossHelper.checkMonopoly(_loc1_))
         {
            return _data.petMonopolySkillList;
         }
         return [null,null,null];
      }
      
      private function get skillStr() : String
      {
         if(!_data)
         {
            return "";
         }
         var _loc1_:int = int(CampaignManager.instance.mapId);
         if(WorldBossHelper.checkMonopoly(_loc1_))
         {
            return _data.petMonopolySkillsOfString;
         }
         return "";
      }
      
      private function set skillStr(param1:String) : void
      {
         if(!_data)
         {
            return;
         }
         var _loc2_:int = int(CampaignManager.instance.mapId);
         if(WorldBossHelper.checkMonopoly(_loc2_))
         {
            _data.petMonopolySkillsOfString = param1;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

