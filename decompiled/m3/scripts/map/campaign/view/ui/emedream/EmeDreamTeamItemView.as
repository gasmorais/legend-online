package map.campaign.view.ui.emedream
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
   import mvc.module.pet.PetData;
   import utils.LogicUtils;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class EmeDreamTeamItemView extends Component
   {
      
      private var _headBack:Image;
      
      private var _headIcon:BaseIconView;
      
      private var _skillList:Vector.<EmeDreamSkillView>;
      
      private var _arrmor01:Bitmap;
      
      private var _arrmor02:Bitmap;
      
      private var _arrmor03:Bitmap;
      
      private var _arrmor04:Bitmap;
      
      private var _arrmorList:Vector.<Bitmap>;
      
      private var _currentSelectedItem:EmeDreamSkillView;
      
      private var _selectSkillView:EmeDreamSkillSelectView;
      
      private var _data:PetData;
      
      public function EmeDreamTeamItemView()
      {
         super();
         initView();
         addEvent();
         this.mouseEnabled = false;
      }
      
      private function initView() : void
      {
         var _loc1_:EmeDreamSkillView = null;
         var _loc2_:int = 0;
         _headBack = ComponentFactory.Instance.creatComponentByStylename("warlordsroom.WarlordsTeamItemView.headBack");
         _headIcon = ComponentFactory.Instance.creatCustomObject("warlordsroom.WarlordsTeamItemView.headIcon");
         _arrmor01 = ComponentFactory.Instance.creatBitmap("asset.warlordsroom.FinalTeamItemArrmorImg");
         _arrmor02 = ComponentFactory.Instance.creatBitmap("asset.warlordsroom.FinalTeamItemArrmorImg");
         _arrmor03 = ComponentFactory.Instance.creatBitmap("asset.warlordsroom.FinalTeamItemArrmorImg");
         _arrmor04 = ComponentFactory.Instance.creatBitmap("asset.warlordsroom.FinalTeamItemArrmorImg");
         _arrmor01.y = _arrmor02.y = _arrmor03.y = _arrmor04.y = 18;
         _arrmor01.x = 95;
         _arrmor02.x = 150;
         _arrmor03.x = 205;
         _arrmor04.x = 260;
         addChild(_headBack);
         addChild(_headIcon);
         addChild(_arrmor01);
         addChild(_arrmor02);
         addChild(_arrmor03);
         addChild(_arrmor04);
         _arrmorList = new Vector.<Bitmap>(4);
         _arrmorList[0] = _arrmor01;
         _arrmorList[1] = _arrmor02;
         _arrmorList[2] = _arrmor03;
         _arrmorList[3] = _arrmor04;
         _skillList = new Vector.<EmeDreamSkillView>(5);
         _loc2_ = 0;
         while(_loc2_ < _skillList.length)
         {
            _loc1_ = new EmeDreamSkillView(_loc2_);
            _loc1_.tipStyle = "yishi.view.tips.goods.SkillTips";
            _loc1_.tipDirctions = "4,1,6,5,2,7,0,3";
            _loc1_.isFollowMouse = false;
            _loc1_.x = 57 + _loc2_ * 55;
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
         ObjectUtils.disposeObject(_arrmor03);
         _arrmor03 = null;
         ObjectUtils.disposeObject(_arrmor04);
         _arrmor04 = null;
         ObjectUtils.disposeObject(_selectSkillView);
         _selectSkillView = null;
         ObjectUtils.disposeObject(_currentSelectedItem);
         _currentSelectedItem = null;
         ObjectUtils.disposeAllChildren(this);
         LogicUtils.disposeDisplayCollection(_skillList);
         LogicUtils.disposeDisplayCollection(_arrmorList);
         _skillList = null;
         _arrmorList = null;
         _data = null;
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
         var _loc3_:int = 0;
         var _loc2_:Array = _data.consortiaBossSkillList;
         _loc3_ = 0;
         while(_loc3_ < _skillList.length)
         {
            _skillList[_loc3_].data = _loc2_[_loc3_] as SkillTempInfo;
            _loc3_++;
         }
         _loc2_ = null;
      }
      
      private function __mouseClickHandler(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = 0;
         var _loc3_:Point = null;
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
         if(param1.target is EmeDreamSkillView)
         {
         }
         var _loc2_:Array = [];
         _loc2_ = data.activeSkillList.concat();
         _loc4_ = _loc2_.length - 1;
         while(_loc4_ >= 0)
         {
            _loc5_ = 0;
            while(_loc5_ < _skillList.length)
            {
               if(_loc2_[_loc4_] == _skillList[_loc5_].data)
               {
                  _loc2_.splice(_loc4_,1);
                  break;
               }
               _loc5_++;
            }
            _loc4_--;
         }
         if(_currentSelectedItem)
         {
            _selectSkillView = new EmeDreamSkillSelectView();
            if(_currentSelectedItem)
            {
               if(_currentSelectedItem.index < 3)
               {
                  _selectSkillView.show(data.activeSkillList,selectSkill,false,this);
               }
               else
               {
                  if(data.activeSkillList.length <= 3)
                  {
                     _selectSkillView.dispose();
                     _selectSkillView = null;
                     return;
                  }
                  if(_currentSelectedItem.data != null)
                  {
                     _selectSkillView.show(data.activeSkillList,selectSkill,true,this);
                  }
                  else if(_loc2_.length != 0)
                  {
                     _selectSkillView.show(_loc2_,selectSkill,false,this);
                  }
               }
            }
            _loc2_ = null;
            _loc3_ = new Point(_currentSelectedItem.displayWidth / 2,_currentSelectedItem.y);
            _loc3_ = _currentSelectedItem.localToGlobal(_loc3_);
            _selectSkillView.x = _loc3_.x - _selectSkillView.displayWidth / 2;
            _selectSkillView.y = _loc3_.y - _selectSkillView.displayHeight - 5;
            if(_selectSkillView.x + _selectSkillView.displayWidth > StageReferance.stageWidth)
            {
               _selectSkillView.x = StageReferance.stageWidth - _selectSkillView.displayWidth;
            }
            else if(_selectSkillView.x < 0)
            {
               _selectSkillView.x = 0;
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
         var _loc2_:Array = data.consortiaBossSkillList;
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
         if(_data.petConsortiaSkillsOfString != _loc4_)
         {
            _data.petConsortiaSkillsOfString = _loc4_;
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
      
      public function hideSkillItems() : void
      {
         var _loc1_:int = 0;
         for each(var _loc2_:EmeDreamSkillView in _skillList)
         {
            _loc2_.visible = false;
         }
         _loc1_ = 0;
         while(_loc1_ < _arrmorList.length)
         {
            _arrmorList[_loc1_].visible = false;
            _loc1_++;
         }
      }
      
      public function showSkillItems() : void
      {
         var _loc1_:int = 0;
         for each(var _loc2_:EmeDreamSkillView in _skillList)
         {
            _loc2_.visible = true;
         }
         _loc1_ = 0;
         while(_loc1_ < _arrmorList.length)
         {
            _arrmorList[_loc1_].visible = true;
            _loc1_++;
         }
      }
      
      public function get currentSelectedItem() : EmeDreamSkillView
      {
         return _currentSelectedItem;
      }
      
      public function get teamItemSkillList() : Array
      {
         return data.consortiaBossSkillList;
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

