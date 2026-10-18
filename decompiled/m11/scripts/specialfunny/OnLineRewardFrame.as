package specialfunny
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import funny.FunnyEvent;
   import funny.datas.FunnyBagData;
   import manager.LanguageMgr;
   import managers.FunnyManager;
   import mvc.ModuleFrameInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.PlayerManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class OnLineRewardFrame extends Frame implements IManualSize
   {
      
      private var _back1:Scale9CornerImage;
      
      private var _back2:Scale9CornerImage;
      
      private var _hourText:FilterFrameText;
      
      private var _minText:FilterFrameText;
      
      private var _getBtn:IconButton;
      
      private var _onlineImage:Bitmap;
      
      private var _hourImage:Bitmap;
      
      private var _minImage:Bitmap;
      
      private var _titleImage:Bitmap;
      
      private var _titleSprite:Sprite;
      
      private var _list:Array = [];
      
      public function OnLineRewardFrame()
      {
         super();
         initView();
         initEvent();
         FunnyManager.instance.sendGetBag(1);
         FunnyManager.instance.selectedId = bagData.activeId;
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("mainBar.TopToolsBar.onlineBtn.tipData");
         _back1 = ComponentFactory.Instance.creatComponentByStylename("onllinereward.back1");
         _back2 = ComponentFactory.Instance.creatComponentByStylename("onllinereward.back2");
         _onlineImage = ComponentFactory.Instance.creatBitmap("asset.onlinereward.image1");
         _hourImage = ComponentFactory.Instance.creatBitmap("asset.onlinereward.image2");
         _minImage = ComponentFactory.Instance.creatBitmap("asset.onlinereward.image3");
         _titleImage = ComponentFactory.Instance.creatBitmap("asset.onlinereward.title");
         _hourText = ComponentFactory.Instance.creatComponentByStylename("onlinereward.titleText");
         _minText = ComponentFactory.Instance.creatComponentByStylename("onlinereward.titleText");
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("onllinereward.getBtn");
         _titleSprite = new Sprite();
         addToContent(_back1);
         addToContent(_back2);
         addToContent(_getBtn);
         _titleSprite.addChild(_onlineImage);
         _titleSprite.addChild(_hourImage);
         _titleSprite.addChild(_minImage);
         _titleSprite.addChild(_titleImage);
         _titleSprite.addChild(_hourText);
         _titleSprite.addChild(_minText);
         addToContent(_titleSprite);
         _titleSprite.y = 4;
         _getBtn.enable = false;
         _minText.x = _hourText.x + 57;
         setView();
         setStatus();
      }
      
      private function setStatus() : void
      {
         switch(int(bagData.status) - 1)
         {
            case 0:
               _getBtn.enable = true;
               _hourText.setFrame(1);
               _minText.setFrame(1);
               break;
            case 1:
               _getBtn.enable = false;
               _hourText.setFrame(2);
               _minText.setFrame(2);
               break;
            case 2:
               _getBtn.enable = false;
               _hourText.setFrame(2);
               _minText.setFrame(2);
         }
      }
      
      private function setView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:BaseItemView = null;
         var _loc4_:GoodsInfo = null;
         var _loc1_:FilterFrameText = null;
         _hourText.text = int(bagData.conditionList[0].value / 3600) + "";
         _minText.text = int(bagData.conditionList[0].value % 3600 / 60) + "";
         _hourText.visible = true;
         _hourImage.visible = true;
         _minText.visible = true;
         _minImage.visible = true;
         _hourText.x = 85;
         _hourImage.x = 112;
         _minText.x = 133;
         _minImage.x = 160;
         _titleImage.x = 203;
         if(_hourText.text == "0")
         {
            _hourText.visible = false;
            _hourImage.visible = false;
            _minText.x = 100;
            _minImage.x = 142;
            _titleImage.x = 190;
         }
         else if(_minText.text == "0")
         {
            _minText.visible = false;
            _minImage.visible = false;
            _hourText.x = 100;
            _hourImage.x = 142;
            _titleImage.x = 190;
         }
         _titleSprite.x = (350 - _titleSprite.width) / 2;
         cleanList();
         _loc3_ = 0;
         while(_loc3_ < bagData.rewardList.length)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("onlinereward.BaseItemView");
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = bagData.rewardList[_loc3_].temId;
            _loc4_.count = bagData.rewardList[_loc3_].count;
            _loc2_.data = _loc4_;
            _loc2_.x = 25 + 163 * (int(_loc3_ % 2));
            _loc2_.y = 40 + 75 * (int(_loc3_ / 2));
            addToContent(_loc2_);
            _list.push(_loc2_);
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("onlinereward.txt");
            _loc1_.text = _loc4_.templateInfo.TemplateName;
            _loc1_.x = _loc2_.x + 62;
            if(_loc1_.numLines == 1)
            {
               _loc1_.y = _loc2_.y + 21;
            }
            else
            {
               _loc1_.y = _loc2_.y + 8;
            }
            addToContent(_loc1_);
            _list.push(_loc1_);
            _loc3_++;
         }
         height = 290 + int((bagData.rewardList.length - 1) / 2) * 75;
         _back1.height = 175 + int((bagData.rewardList.length - 1) / 2) * 75;
         _back2.height = 81 + int((bagData.rewardList.length - 1) / 2) * 75;
         _getBtn.y = 119 + int((bagData.rewardList.length - 1) / 2) * 75;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      private function __getHandler(param1:MouseEvent) : void
      {
         if(_getBtn)
         {
            _getBtn.enable = false;
         }
         if(bagData == null)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("feedback.FeedBackItem.outDate"));
            return;
         }
         if(bagData)
         {
            FunnyManager.instance.sendGetBag(2,bagData.activeId,bagData.id);
         }
      }
      
      private function __updateHandler(param1:FunnyEvent) : void
      {
         if(bagData == null)
         {
            dispose();
            return;
         }
         setView();
         setStatus();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_getBtn)
         {
            _getBtn.addEventListener("click",__getHandler);
         }
         FunnyManager.instance.addEventListener("REFRESH_ITEM",__updateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_getBtn)
         {
            _getBtn.removeEventListener("click",__getHandler);
         }
         FunnyManager.instance.removeEventListener("REFRESH_ITEM",__updateHandler);
      }
      
      private function get bagData() : FunnyBagData
      {
         return FunnyManager.instance.model.onLineCurrentData;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,385,348);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      private function cleanList() : void
      {
         if(_list == null)
         {
            return;
         }
         while(_list.length > 0)
         {
            _list.pop().dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         cleanList();
         ObjectUtils.disposeObject(_back1);
         _back1 = null;
         ObjectUtils.disposeObject(_back2);
         _back2 = null;
         ObjectUtils.disposeObject(_hourText);
         _hourText = null;
         ObjectUtils.disposeObject(_minText);
         _minText = null;
         ObjectUtils.disposeObject(_getBtn);
         _getBtn = null;
         ObjectUtils.disposeObject(_titleImage);
         _titleImage = null;
         ObjectUtils.disposeObject(_onlineImage);
         _onlineImage = null;
         ObjectUtils.disposeObject(_hourImage);
         _hourImage = null;
         ObjectUtils.disposeObject(_minImage);
         _minImage = null;
         KeyBoardRegister.instance.keyEnable = true;
         _titleSprite = null;
         super.dispose();
      }
   }
}

