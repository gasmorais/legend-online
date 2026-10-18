package map.campaign.mediator.singlecampaign
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignSocketOutManager;
   import mvc.module.singlecampaign.SingleCampaignModel;
   import yishi.datas.templates.SingleCampaignDataTempInfo;
   import yishi.filter.UIFilter;
   import yishi.utils.StringHelper;
   
   public class SingleCampaignNpcNode extends Component
   {
      
      private var _pillarImage:ScaleFrameImage;
      
      private var _boosLight:Bitmap;
      
      private var _avatar:SingleCampaignNpcAvatarView;
      
      private var _challengeBtn:BaseButton;
      
      private var index:int;
      
      private var _data:SingleCampaignDataTempInfo;
      
      public function SingleCampaignNpcNode(param1:int)
      {
         super();
         index = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _pillarImage = ComponentFactory.Instance.creatComponentByStylename("SingleCampaignNpcNode.pillarImage");
         _boosLight = ComponentFactory.Instance.creatBitmap("asset.SingleCampaignNpcNode.boosLight");
         _challengeBtn = ComponentFactory.Instance.creatComponentByStylename("SingleCampaignNpcNode.challengeBtn");
         _avatar = new SingleCampaignNpcAvatarView();
         addChild(_pillarImage);
         addChild(_boosLight);
         addChild(_avatar);
         addChild(_challengeBtn);
         _pillarImage.setFrame(index);
         setAvatarPos();
      }
      
      private function addEvent() : void
      {
         _challengeBtn.addEventListener("click",__challengeClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_challengeBtn)
         {
            _challengeBtn.removeEventListener("click",__challengeClickHandler);
         }
      }
      
      private function __challengeClickHandler(param1:MouseEvent) : void
      {
         CampaignSocketOutManager.instance.sendSingleCampaignFight();
      }
      
      public function get data() : SingleCampaignDataTempInfo
      {
         return _data;
      }
      
      public function set data(param1:SingleCampaignDataTempInfo) : void
      {
         _data = param1;
         var _loc2_:Boolean = false;
         if(data)
         {
            _pillarImage.visible = true;
            _avatar.data = data;
            setAvatarPos();
            _loc2_ = !StringHelper.isNullOrEmpty(data.Heros);
            _boosLight.visible = _loc2_;
            _challengeBtn.visible = singleModel.curIndex == data.Index;
            if(singleModel.curIndex > data.Index)
            {
               this.filters = [UIFilter.getGrayFilter()];
            }
            else
            {
               this.filters = [];
            }
         }
         else
         {
            _avatar.data = null;
            _boosLight.visible = false;
            _challengeBtn.visible = false;
            _pillarImage.visible = false;
            this.filters = [];
         }
      }
      
      private function setAvatarPos() : void
      {
         _avatar.x = 0;
         _avatar.y = 25;
         if(index % 2 == 0)
         {
            _avatar.x = -10;
            _challengeBtn.x = -100;
         }
         if(data)
         {
            _avatar.x += data.Param1;
            _avatar.y += data.Param2;
         }
      }
      
      private function get singleModel() : SingleCampaignModel
      {
         return CampaignManager.instance.singleCampaignModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_pillarImage);
         _pillarImage = null;
         ObjectUtils.disposeObject(_boosLight);
         _boosLight = null;
         ObjectUtils.disposeObject(_challengeBtn);
         _challengeBtn = null;
         ObjectUtils.disposeObject(_avatar);
         _avatar = null;
         super.dispose();
      }
   }
}

