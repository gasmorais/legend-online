package secretadventure.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.secret.SecretAdventureModel;
   import mvc.module.secret.SecretFrameInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.SecretMapLevelTemplate;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SecretAdventerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.base.ProgressPanel;
   import yishi.view.community.BaseItemView;
   import yishi.view.community.TimeDownView;
   
   public class SecretAdLeftView extends Sprite
   {
      
      private var _leftBbg:MutipleImage;
      
      private var _leftPgress:FilterFrameText;
      
      private var _riverTime:FilterFrameText;
      
      private var _riverBtn:IconButton;
      
      private var _fightTxt:FilterFrameText;
      
      private var _hpProgress:ProgressPanel;
      
      private var _info:SecretFrameInfo;
      
      private var _panel:SimpleTileList;
      
      private var _itemList:Array = [];
      
      private var _time:TimeDownView;
      
      public function SecretAdLeftView()
      {
         super();
         initView();
         initEvent();
      }
      
      public function set info(param1:SecretFrameInfo) : void
      {
         var _loc2_:Number = NaN;
         _info = param1;
         if(_info)
         {
            _fightTxt.text = "" + _info.fight;
            _hpProgress.progressValue(_info.currHp,_info.initHp);
            if(_info.currHp == 0)
            {
               _riverBtn.enable = true;
               _riverTime.visible = true;
               _time.visible = true;
               _loc2_ = getRiverTime();
               _time.timeCount = _loc2_ / 1000;
            }
            else
            {
               _riverTime.visible = false;
               _riverBtn.enable = false;
               _time.visible = false;
            }
         }
      }
      
      private function getRiverTime() : Number
      {
         var _loc1_:Date = null;
         var _loc5_:PlayerModel = PlayerManager.instance.currentPlayerModel;
         if(_loc5_.castle_offset == -1)
         {
            _loc1_ = _loc5_.sysCurtime;
         }
         else
         {
            _loc1_ = DateFormatter.getTimezoneOffsetDate(_loc5_.castle_offset);
         }
         var _loc2_:Number = _loc1_.time;
         var _loc4_:Number = Number(DateFormatter.parse(_info.remainTime,"YYYY-MM-DD hh:mm:ss").time);
         var _loc3_:Number = _loc4_ - _loc2_ - 2000;
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         return _loc3_;
      }
      
      private function initView() : void
      {
         _leftBbg = ComponentFactory.Instance.creatComponentByStylename("ui.secretadventure.leftBbg");
         _leftPgress = ComponentFactory.Instance.creatComponentByStylename("ui.secretadventure.leftPgress");
         _riverTime = ComponentFactory.Instance.creatComponentByStylename("ui.secretadventure.riverTime");
         _riverBtn = ComponentFactory.Instance.creatComponentByStylename("ui.secretadventure.riverBtn");
         _fightTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretadventure.fightTxt");
         _hpProgress = ComponentFactory.Instance.creatCustomObject("ui.secretadventure.hpPanel");
         _hpProgress.initView("asset.secretad.hpbg","asset.secretad.hpbar","ui.secretadventure.hpProgressTxt");
         _panel = ComponentFactory.Instance.creatCustomObject("ui.secretad.dropTitleList",[4]);
         _time = ComponentFactory.Instance.creatComponentByStylename("secret.frame.reiverTimeDown");
         addChild(_leftBbg);
         addChild(_panel);
         addChild(_leftPgress);
         addChild(_riverTime);
         addChild(_riverBtn);
         addChild(_fightTxt);
         addChild(_hpProgress);
         addChild(_time);
         _riverBtn.enable = false;
         _riverTime.visible = false;
         _riverTime.text = LanguageMgr.GetTranslation("secret.frame.riverTime");
      }
      
      private function initEvent() : void
      {
         _riverBtn.addEventListener("click",clickRiverHandler);
         _time.addEventListener("timerDown_complete",timeCompleteHandler);
      }
      
      private function removeEvent() : void
      {
         _riverBtn.removeEventListener("click",clickRiverHandler);
         _time.removeEventListener("timerDown_complete",timeCompleteHandler);
      }
      
      private function timeCompleteHandler(param1:Event) : void
      {
         if(_info && _info.currHp <= 0)
         {
            SecretAdventerManager.Instance.opCommon(4);
         }
      }
      
      private function clickRiverHandler(param1:MouseEvent) : void
      {
         var _loc4_:Number = getRiverTime();
         var _loc6_:int = Math.ceil(_loc4_ * 0.001 / 3600);
         var _loc5_:int = int(TempleteManager.instance.getConfigValue("secretexplore_revive_cost_diamonds"));
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc7_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc8_:String = LanguageMgr.GetTranslation("secret.reiver.tip",_loc5_ * _loc6_);
         SimpleAlertHelper.instance.data = [confromBack,_loc5_];
         SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc8_,_loc2_,_loc3_,false,true);
      }
      
      private function confromBack(param1:Boolean, param2:Boolean = false, param3:int = 10) : void
      {
         if(param1)
         {
            if(param3 > PlayerManager.instance.currentPlayerModel.playerInfo.point)
            {
               RechargeAlertMannager.show();
               return;
            }
            SecretAdventerManager.Instance.opCommon(4);
         }
      }
      
      public function mapLvChang(param1:SecretMapLevelTemplate) : void
      {
         var _loc3_:BaseItemView = null;
         var _loc8_:int = 0;
         var _loc7_:GoodsInfo = null;
         var _loc6_:int = 0;
         _panel.removeAllChild();
         _panel.beginChanges();
         var _loc5_:Array = param1.Drop.split(",");
         var _loc4_:int = int(_loc5_ ? _loc5_.length : 0);
         var _loc2_:int = int(_itemList.length);
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc8_ = int(_loc5_[_loc6_]);
            _loc7_ = new GoodsInfo();
            _loc7_.templateId = _loc8_;
            if(_loc6_ < _loc2_)
            {
               _loc3_ = _itemList[_loc6_];
            }
            else
            {
               _loc3_ = ComponentFactory.Instance.creatCustomObject("core.BaseItemView");
               _itemList.push(_loc3_);
            }
            _loc3_.data = _loc7_;
            _panel.addChild(_loc3_);
            _loc6_++;
         }
         _panel.commitChanges();
      }
      
      private function get model() : SecretAdventureModel
      {
         return SecretAdventerManager.Instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_leftBbg);
         _leftBbg = null;
         ObjectUtils.disposeObject(_leftPgress);
         _leftPgress = null;
         ObjectUtils.disposeObject(_riverTime);
         _riverTime = null;
         ObjectUtils.disposeObject(_riverBtn);
         _riverBtn = null;
         ObjectUtils.disposeObject(_fightTxt);
         _fightTxt = null;
         ObjectUtils.disposeObject(_hpProgress);
         _hpProgress = null;
         for each(var _loc1_:BaseItemView in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _itemList = null;
         ObjectUtils.disposeObject(_panel);
         _panel = null;
         ObjectUtils.disposeObject(_time);
         _time = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _info = null;
      }
   }
}

