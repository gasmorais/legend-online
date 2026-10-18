package remotepet.views
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import events.PetEvent;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import mvc.module.pet.PetData;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.filter.UIFilter;
   
   public class RemotePetSkillsView extends Component
   {
      
      private var _skillList:Vector.<RemotePetSkillItemView>;
      
      private var _arrmor01:Bitmap;
      
      private var _arrmor02:Bitmap;
      
      private var _data:PetData;
      
      private var _currentSelectedItem:RemotePetSkillItemView;
      
      private var _selectSkillView:RemotePetSkillSelectView;
      
      public function RemotePetSkillsView()
      {
         super();
         initView();
         this.mouseEnabled = false;
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:RemotePetSkillItemView = null;
         _arrmor01 = ComponentFactory.Instance.creatBitmap("asset.remotepet.ArrmorImg");
         _arrmor02 = ComponentFactory.Instance.creatBitmap("asset.remotepet.ArrmorImg");
         _arrmor01.y = _arrmor02.y = 15;
         _arrmor01.x = 44;
         _arrmor02.x = 112;
         addChild(_arrmor01);
         addChild(_arrmor02);
         _skillList = new Vector.<RemotePetSkillItemView>(3);
         _loc2_ = 0;
         while(_loc2_ < _skillList.length)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("remotepet.RemotePetSkillItemView",[_loc2_]);
            _loc1_.x = _loc2_ * 68;
            _loc1_.y = 5;
            addChild(_loc1_);
            _skillList[_loc2_] = _loc1_;
            _loc2_++;
         }
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_arrmor01);
         _arrmor01 = null;
         ObjectUtils.disposeObject(_arrmor02);
         _arrmor02 = null;
         if(_selectSkillView)
         {
            _selectSkillView.dispose();
            _selectSkillView = null;
         }
         _skillList = null;
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
         __skillChangeHandler(null);
      }
      
      private function clean() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _skillList.length)
         {
            _skillList[_loc1_].data = null;
            _loc1_++;
         }
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
         var _loc2_:Array = _data.remotePetSkillList;
         _loc3_ = 0;
         while(_loc3_ < _skillList.length)
         {
            _skillList[_loc3_].data = _loc2_[_loc3_] as SkillTempInfo;
            _loc3_++;
         }
         _loc2_ = null;
         if(_data.remoteHp == 0)
         {
            this.filters = [UIFilter.getBlackFilter()];
         }
         else
         {
            this.filters = [];
         }
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
         if(param1.target is RemotePetSkillItemView)
         {
            _currentSelectedItem = param1.target as RemotePetSkillItemView;
         }
         if(_currentSelectedItem)
         {
            _selectSkillView = new RemotePetSkillSelectView();
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
         var _loc2_:Array = data.remotePetSkillList;
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
         if(_data.remotePetSkillsOfString != _loc4_)
         {
            _data.remotePetSkillsOfString = _loc4_;
         }
         _selectSkillView = null;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uintView();
         super.dispose();
         _data = null;
      }
   }
}

