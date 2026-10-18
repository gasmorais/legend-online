package map.campaign.view.ui.airgarden
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import managers.AirGardenManager;
   import mvc.module.airgarden.AirGardenModel;
   import mvc.module.airgarden.AirGardenPartyInfo;
   import yishi.SwitchPageHelp;
   
   public class AirGardenCampaignRightItem extends Component
   {
      
      private var _rankImage:ScaleFrameImage;
      
      private var _rankText:FilterFrameText;
      
      private var _nameText:FilterFrameText;
      
      private var _upText:FilterFrameText;
      
      private var _selectBg:Bitmap;
      
      private var index:int;
      
      private var _pageNum:int;
      
      private var _data:AirGardenPartyInfo;
      
      private var pageCount:int = 10;
      
      public function AirGardenCampaignRightItem(param1:int)
      {
         super();
         index = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _rankImage = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignRightItem.rankImage");
         _rankText = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignRightItem.rankText");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignRightItem.nameText");
         _upText = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignRightItem.upText");
         _selectBg = ComponentFactory.Instance.creatBitmap("asset.AirGardenCampaignRightItem.selectBg");
         addChild(_selectBg);
         addChild(_rankImage);
         addChild(_rankText);
         addChild(_nameText);
         addChild(_upText);
         this.buttonMode = true;
      }
      
      private function addEvent() : void
      {
         this.addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",__clickHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         if(model.campaignInfo.masterUserId == data.masterUserId)
         {
            return;
         }
         SoundManager.instance.play("022");
         SwitchPageHelp.enterAirGardenCampaign(data.masterUserId);
      }
      
      public function get pageNum() : int
      {
         return _pageNum;
      }
      
      public function set pageNum(param1:int) : void
      {
         _pageNum = param1;
      }
      
      public function get data() : AirGardenPartyInfo
      {
         return _data;
      }
      
      public function set data(param1:AirGardenPartyInfo) : void
      {
         var _loc2_:int = 0;
         _data = param1;
         if(data)
         {
            _loc2_ = (pageNum - 1) * pageCount + index;
            if(_loc2_ <= 3)
            {
               _rankImage.visible = true;
               _rankImage.setFrame(_loc2_);
               _rankText.text = "";
            }
            else
            {
               _rankImage.visible = false;
               _rankText.text = _loc2_ + "";
            }
            _nameText.text = data.nickName;
            _upText.text = data.upCount + "";
            _selectBg.visible = model.campaignInfo.masterUserId == data.masterUserId;
         }
         else
         {
            _selectBg.visible = false;
            _rankImage.visible = false;
            _rankText.text = "";
            _nameText.text = "";
            _upText.text = "";
         }
      }
      
      private function get model() : AirGardenModel
      {
         return AirGardenManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_selectBg);
         _selectBg = null;
         ObjectUtils.disposeObject(_rankImage);
         _rankImage = null;
         ObjectUtils.disposeObject(_rankText);
         _rankText = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_upText);
         _upText = null;
         super.dispose();
      }
   }
}

