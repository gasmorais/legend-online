package unrealshooting.room
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.campaign.data.UnrealShootingModel;
   import map.campaign.data.UnrealShootingUserInfo;
   import mvc.controler.UnrealShootingController;
   import utils.LogicUtils;
   import yishi.manager.FrameControllerManager;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class UnrealShootingRoomRightView extends Sprite implements Disposeable
   {
      
      private const MAX_COUNT:int = 8;
      
      private var _bg:Image;
      
      private var _titleTxt:Image;
      
      private var _indexTitleTxt:FilterFrameText;
      
      private var _nameTitleTxt:FilterFrameText;
      
      private var _headTitleTxt:FilterFrameText;
      
      private var _itemVBox:VBox;
      
      private var _itemList:Vector.<UnrealShootingRoomRightItemView>;
      
      private var _helpBtn:BaseButton;
      
      private var _controller:UnrealShootingController;
      
      private var _model:UnrealShootingModel;
      
      public function UnrealShootingRoomRightView()
      {
         super();
         _controller = FrameControllerManager.instance.unrealShootingController;
         _model = _controller.model;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRoomRightView.bg");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRoomRightView.titleTxt");
         _indexTitleTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRoomRightView.indexTitleTxt");
         _nameTitleTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRoomRightView.nameTitleTxt");
         _headTitleTxt = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRoomRightView.headTitleTxt");
         _itemVBox = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRoomRightView.ItemVBox");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRoomRightView.helpBtn");
         _indexTitleTxt.text = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingRoomRightView.indexTitleTxt");
         _nameTitleTxt.text = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingRoomRightView.nameTitleTxt");
         _headTitleTxt.text = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingRoomRightView.headTitleTxt");
         addChild(_bg);
         addChild(_titleTxt);
         addChild(_indexTitleTxt);
         addChild(_nameTitleTxt);
         addChild(_headTitleTxt);
         addChild(_itemVBox);
         addChild(_helpBtn);
         initItemListView();
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         ObjectUtils.disposeObject(_indexTitleTxt);
         _indexTitleTxt = null;
         ObjectUtils.disposeObject(_nameTitleTxt);
         _nameTitleTxt = null;
         ObjectUtils.disposeObject(_headTitleTxt);
         _headTitleTxt = null;
         ObjectUtils.disposeObject(_itemVBox);
         _itemVBox = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         _controller = null;
         _model = null;
      }
      
      private function initItemListView() : void
      {
         var _loc1_:UnrealShootingRoomRightItemView = null;
         var _loc3_:int = 0;
         _itemList = new Vector.<UnrealShootingRoomRightItemView>();
         var _loc2_:int = 8;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = new UnrealShootingRoomRightItemView();
            _loc1_.data = null;
            _itemList.push(_loc1_);
            _itemVBox.addChild(_loc1_);
            _loc3_++;
         }
      }
      
      private function addEvent() : void
      {
         _helpBtn.addEventListener("click",__helpBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         _helpBtn.removeEventListener("click",__helpBtnClickHandler);
      }
      
      private function __helpBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.HelperFrame");
         _loc2_.show();
      }
      
      public function refreshView() : void
      {
         var _loc1_:UnrealShootingRoomRightItemView = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _itemList.length)
         {
            _loc1_ = _itemList[_loc2_];
            if(_model.playerList && _loc2_ < _model.playerList.length)
            {
               _loc1_.data = _model.playerList[_loc2_] as UnrealShootingUserInfo;
            }
            else
            {
               _loc1_.data = null;
            }
            _loc2_++;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

