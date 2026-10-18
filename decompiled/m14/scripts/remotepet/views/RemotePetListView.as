package remotepet.views
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.RemotePetEvent;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.RemotePetManager;
   import mvc.module.pet.PetData;
   import mvc.module.remotepet.RemotePetModel;
   import remotepet.RemotePetFriendFrame;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   
   public class RemotePetListView extends Component
   {
      
      private var _back:Bitmap;
      
      private var _arr:Array = [1,2,3,7];
      
      private var _titleImg:MutipleImage;
      
      private var _restText:FilterFrameText;
      
      private var _enterWarText:FilterFrameText;
      
      private var _tipText:FilterFrameText;
      
      private var _petHradList:Vector.<RemotePetHeadItemView>;
      
      private var _petSkillList:Vector.<RemotePetSkillsView>;
      
      private var _currentSelectedItem:RemotePetHeadItemView;
      
      private var _selectPetView:RemotePetHeadSelectView;
      
      public function RemotePetListView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:RemotePetHeadItemView = null;
         var _loc5_:int = 0;
         var _loc4_:RemotePetSkillsView = null;
         _back = ComponentFactory.Instance.creatBitmap("asset.remotepet.petBack");
         _titleImg = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetListView.titleImg");
         _restText = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetListView.restText");
         _enterWarText = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetListView.enterWarText");
         _tipText = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetListView.tipText");
         _restText.text = LanguageMgr.GetTranslation("remotepet.RemotePetListView.restText");
         _enterWarText.text = LanguageMgr.GetTranslation("remotepet.RemotePetListView.enterWarText");
         _tipText.text = LanguageMgr.GetTranslation("remotepet.RemotePetListView.tipText");
         addChild(_back);
         addChild(_titleImg);
         addChild(_enterWarText);
         addChild(_tipText);
         _petHradList = new Vector.<RemotePetHeadItemView>(7);
         var _loc2_:Array = [{
            "x":90,
            "y":70
         },{
            "x":90,
            "y":130
         },{
            "x":90,
            "y":190
         },{
            "x":20,
            "y":70
         },{
            "x":20,
            "y":130
         },{
            "x":20,
            "y":190
         },{
            "x":90,
            "y":250
         }];
         _loc3_ = 0;
         while(_loc3_ < 7)
         {
            _loc1_ = new RemotePetHeadItemView(_loc3_ + 1);
            _loc1_.x = _loc2_[_loc3_].x;
            _loc1_.y = _loc2_[_loc3_].y;
            _loc1_.addEventListener("click",__mouseClickHandler);
            addChild(_loc1_);
            if(_loc3_ >= 3 && _loc3_ <= 5)
            {
               _loc1_.visible = false;
            }
            _petHradList[_loc3_] = _loc1_;
            _loc3_++;
         }
         _petHradList[6].disableDelete();
         _petSkillList = new Vector.<RemotePetSkillsView>(4);
         _loc5_ = 0;
         while(_loc5_ < 4)
         {
            _loc4_ = new RemotePetSkillsView();
            _loc4_.x = 165;
            _loc4_.y = 70 + _loc5_ * 60;
            addChild(_loc4_);
            _petSkillList[_loc5_] = _loc4_;
            _loc5_++;
         }
         __petChangeHandler(null);
      }
      
      private function __mouseClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:RemotePetFriendFrame = null;
         var _loc3_:Point = null;
         if(_currentSelectedItem == param1.currentTarget && _selectPetView)
         {
            _selectPetView.dispose();
            _selectPetView = null;
            return;
         }
         _currentSelectedItem = null;
         if(param1.currentTarget is RemotePetHeadItemView)
         {
            _currentSelectedItem = param1.currentTarget as RemotePetHeadItemView;
         }
         if(_currentSelectedItem && _currentSelectedItem["pos"] == 7)
         {
            if(model.petListInfo.petList[7])
            {
               return;
            }
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetFriendFrame");
            _loc2_.show();
            return;
         }
         if(_currentSelectedItem)
         {
            _selectPetView = new RemotePetHeadSelectView();
            _selectPetView.show(playerInfo.petList,_currentSelectedItem["data"],selectPet);
            _loc3_ = new Point(_currentSelectedItem.displayWidth / 2,0);
            _loc3_ = _currentSelectedItem.localToGlobal(_loc3_);
            _selectPetView.x = _loc3_.x - _selectPetView.displayWidth / 2;
            _selectPetView.y = _loc3_.y - _selectPetView.displayHeight - 5;
            if(_selectPetView.x + _selectPetView.displayWidth > StageReferance.stageWidth)
            {
               _selectPetView.x = StageReferance.stageWidth - _selectPetView.displayWidth;
            }
         }
         param1.stopPropagation();
      }
      
      private function selectPet(param1:PetData) : void
      {
         var _loc7_:PetData = null;
         var _loc5_:Array = null;
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         for(var _loc4_:String in model.petListInfo.petList)
         {
            if(int(_loc4_) != _currentSelectedItem["pos"] && int(_loc4_) != 7)
            {
               _loc2_.push(int(_loc4_));
            }
         }
         for each(var _loc6_:int in _loc2_)
         {
            if(model.petListInfo.petList[_loc6_])
            {
               _loc3_.push(model.petListInfo.petList[_loc6_].template.PetType);
            }
         }
         if(_currentSelectedItem.data == param1)
         {
            _loc7_ = param1;
            _currentSelectedItem.data = null;
            param1 = null;
         }
         else
         {
            _loc7_ = _currentSelectedItem.data;
            _currentSelectedItem.data = param1;
         }
         model.petListInfo.petList[_currentSelectedItem["pos"]] = param1;
         if(_currentSelectedItem["pos"] <= 3)
         {
            _loc5_ = [];
            if(_loc7_)
            {
               _loc5_.push(_loc7_);
            }
            _loc5_.push(param1);
            model.petChange(_loc5_);
         }
         model.commit();
         _selectPetView = null;
      }
      
      private function addEvent() : void
      {
         model.addEventListener("PET_CHANGE",__petChangeHandler);
         model.addEventListener("COMMIT",__petChangeHandler);
      }
      
      private function removeEvent() : void
      {
         model.removeEventListener("PET_CHANGE",__petChangeHandler);
         model.removeEventListener("COMMIT",__petChangeHandler);
      }
      
      private function __petChangeHandler(param1:RemotePetEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _petHradList.length)
         {
            _petHradList[_loc2_].data = model.petListInfo.petList[_loc2_ + 1];
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _petSkillList.length)
         {
            _petSkillList[_loc3_].data = model.petListInfo.petList[_arr[_loc3_]];
            _loc3_++;
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get model() : RemotePetModel
      {
         return RemotePetManager.instance.model;
      }
      
      private function uintView() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         ObjectUtils.disposeObject(_titleImg);
         _titleImg = null;
         ObjectUtils.disposeObject(_restText);
         _restText = null;
         ObjectUtils.disposeObject(_enterWarText);
         _enterWarText = null;
         ObjectUtils.disposeObject(_tipText);
         _tipText = null;
         for each(_loc2_ in _petHradList)
         {
            ObjectUtils.disposeObject(_loc2_);
         }
         _petHradList = null;
         for each(_loc1_ in _petSkillList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _petSkillList = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      override public function dispose() : void
      {
         if(_selectPetView)
         {
            _selectPetView.dispose();
            _selectPetView = null;
         }
         removeEvent();
         uintView();
         super.dispose();
      }
   }
}

