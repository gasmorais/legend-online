package remotepet.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.RemotePetManager;
   import mvc.module.remotepet.RemotePetFriendInfo;
   import mvc.module.remotepet.RemotePetModel;
   
   public class RemotePetFriendItemView extends SelectedButton implements IListCell
   {
      
      private var _line:Bitmap;
      
      private var _itemBg:ScaleFrameImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _fightTxt:FilterFrameText;
      
      private var _petInfoTxt:FilterFrameText;
      
      private var _data:RemotePetFriendInfo;
      
      public function RemotePetFriendItemView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _itemBg = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetFriendItemView.ItemBg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetFriendItemView.nameTxt");
         _fightTxt = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetFriendItemView.fightTxt");
         _petInfoTxt = ComponentFactory.Instance.creatComponentByStylename("remotepet.RemotePetFriendItemView.petInfoTxt");
         _line = ComponentFactory.Instance.creatBitmap("asset.remotepet.RemotePetFriendItemView.ItemLine");
         addChild(_itemBg);
         addChild(_nameTxt);
         addChild(_fightTxt);
         addChild(_petInfoTxt);
         addChild(_line);
         _itemBg.setFrame(1);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeObject(_itemBg);
         _itemBg = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_fightTxt);
         _fightTxt = null;
         ObjectUtils.disposeObject(_petInfoTxt);
         _petInfoTxt = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function __onItemClick(param1:MouseEvent) : void
      {
      }
      
      override public function set selected(param1:Boolean) : void
      {
         super.selected = param1;
         if(param1)
         {
            model.selectItem = _data;
         }
         if(_data)
         {
            selectedEffect(param1);
         }
      }
      
      private function selectedEffect(param1:Boolean) : void
      {
         if(param1)
         {
            _itemBg.setFrame(2);
         }
         else
         {
            _itemBg.setFrame(1);
         }
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      public function setCellValue(param1:*) : void
      {
         data = param1 as RemotePetFriendInfo;
      }
      
      public function set data(param1:RemotePetFriendInfo) : void
      {
         if(!param1)
         {
            return;
         }
         _data = param1;
         updateView();
      }
      
      override public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
         selected = param2;
      }
      
      private function updateView() : void
      {
         _nameTxt.text = _data.friendName;
         _fightTxt.text = _data.petFight.toString();
         _petInfoTxt.text = _data.petName + "(" + petTypeLanguage + ")";
         var _loc1_:int = 0;
         if(_data.petQuality < 26)
         {
            _loc1_ = (_data.petQuality - 1) / 5 + 1;
         }
         else
         {
            _loc1_ = (_data.petQuality - 1) / 5;
         }
         if(_loc1_ < 1)
         {
            _loc1_ = 1;
         }
         _petInfoTxt.setFrame(_loc1_);
      }
      
      public function get petTypeLanguage() : String
      {
         var _loc2_:String = LanguageMgr.GetTranslation("pet.petTypeList");
         var _loc1_:Array = _loc2_.split("|");
         var _loc3_:int = _data.petType - 100;
         if(_loc3_ < 7)
         {
            return _loc1_[_loc3_ - 1];
         }
         return _loc1_[_loc3_ - 11];
      }
      
      private function get model() : RemotePetModel
      {
         return RemotePetManager.instance.model;
      }
      
      override public function dispose() : void
      {
         uninitView();
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

