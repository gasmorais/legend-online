package airgarden.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import mvc.module.airgarden.AirGardenPartyInfo;
   import utils.LogicUtils;
   import yishi.SwitchPageHelp;
   import yishi.utils.IconFactory;
   import yishi.view.base.TokenAmountItem;
   import yishi.view.community.BaseIconView;
   
   public class AirGardenJoinPartyItem extends Component
   {
      
      private var _itemBack:MutipleImage;
      
      private var _headIcon:BaseIconView;
      
      private var _nameText:FilterFrameText;
      
      private var _declarationText:FilterFrameText;
      
      private var _upItem:TokenAmountItem;
      
      private var _gameHbox:HBox;
      
      private var _joinBtn:IconButton;
      
      private var gameList:Vector.<TokenAmountItem>;
      
      private var gameCount:int = 3;
      
      private var _data:AirGardenPartyInfo;
      
      public function AirGardenJoinPartyItem()
      {
         super();
         initView();
         initGameBox();
         addEvent();
      }
      
      private function initView() : void
      {
         _itemBack = ComponentFactory.Instance.creatComponentByStylename("AirGardenJoinPartyItem.itemBack");
         _headIcon = ComponentFactory.Instance.creatCustomObject("AirGardenJoinPartyItem.headIcon");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("AirGardenJoinPartyItem.nameText");
         _declarationText = ComponentFactory.Instance.creatComponentByStylename("AirGardenJoinPartyItem.declarationText");
         _joinBtn = ComponentFactory.Instance.creatComponentByStylename("AirGardenJoinPartyItem.joinBtn");
         _upItem = ComponentFactory.Instance.creatComponentByStylename("AirGardenJoinPartyItem.upItem");
         _gameHbox = ComponentFactory.Instance.creatComponentByStylename("AirGardenJoinPartyItem.gameHbox");
         addChild(_itemBack);
         addChild(_headIcon);
         addChild(_nameText);
         addChild(_declarationText);
         addChild(_upItem);
         addChild(_gameHbox);
         addChild(_joinBtn);
      }
      
      private function initGameBox() : void
      {
         var _loc2_:int = 0;
         var _loc1_:TokenAmountItem = null;
         gameList = new Vector.<TokenAmountItem>();
         _loc2_ = 0;
         while(_loc2_ < gameCount)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("AirGardenJoinPartyItem.gameItem" + _loc2_);
            _gameHbox.addChild(_loc1_);
            gameList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         _joinBtn.addEventListener("click",__joinClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_joinBtn)
         {
            _joinBtn.removeEventListener("click",__joinClickHandler);
         }
      }
      
      private function __joinClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         SwitchPageHelp.enterAirGardenCampaign(data.masterUserId);
      }
      
      public function get data() : AirGardenPartyInfo
      {
         return _data;
      }
      
      public function set data(param1:AirGardenPartyInfo) : void
      {
         var _loc3_:int = 0;
         var _loc2_:TokenAmountItem = null;
         _data = param1;
         if(data)
         {
            _headIcon.icon = IconFactory.getHeadIcon(data.headId,"smallhead",".jpg");
            _nameText.text = data.nickName;
            _declarationText.text = data.intro;
            _joinBtn.visible = true;
            if(data.isParty)
            {
               _gameHbox.visible = true;
               _upItem.visible = false;
               _loc3_ = 0;
               while(_loc3_ < gameCount)
               {
                  _loc2_ = gameList[_loc3_];
                  _loc2_.firstText = data.gameRemainList[_loc3_] + "";
                  _loc3_++;
               }
            }
            else
            {
               _gameHbox.visible = false;
               _upItem.visible = true;
               _upItem.firstText = data.upCount + "";
            }
         }
         else
         {
            _headIcon.icon = null;
            _nameText.text = "";
            _declarationText.text = "";
            _gameHbox.visible = false;
            _upItem.visible = false;
            _joinBtn.visible = false;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_itemBack);
         _itemBack = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_declarationText);
         _declarationText = null;
         ObjectUtils.disposeObject(_upItem);
         _upItem = null;
         ObjectUtils.disposeObject(_joinBtn);
         _joinBtn = null;
         ObjectUtils.disposeObject(_headIcon);
         _headIcon = null;
         ObjectUtils.disposeObject(_gameHbox);
         _gameHbox = null;
         LogicUtils.disposeDisplayCollection(gameList);
         gameList = null;
         super.dispose();
      }
   }
}

