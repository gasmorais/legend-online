package outyard.titan
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.titanland.TitanlandOpMsg;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DragonTitanManager;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.OutyardManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class OutyardTitanRightView extends Component
   {
      
      private var _skillIcon1:BaseIconView;
      
      private var _skillIcon2:BaseIconView;
      
      private var _skillIcon3:BaseIconView;
      
      private var _skillTxt1:FilterFrameText;
      
      private var _skillTxt2:FilterFrameText;
      
      private var _skillTxt3:FilterFrameText;
      
      private var _skillBtn1:BaseButton;
      
      private var _skillBtn2:BaseButton;
      
      private var _skillBtn3:BaseButton;
      
      private var _challengeBtn:IconButton;
      
      private var _noteText1:FilterFrameText;
      
      private var _noteText2:FilterFrameText;
      
      private var _titanBmp1:Bitmap;
      
      private var _titanBmp2:Bitmap;
      
      private var _buffTxtVbox:VBox;
      
      private var _buffTxtArr:Array = [];
      
      public function OutyardTitanRightView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc7_:int = 0;
         var _loc8_:SkillTempInfo = null;
         var _loc9_:int = 0;
         var _loc6_:Array = null;
         var _loc3_:FilterFrameText = null;
         var _loc2_:FilterFrameText = null;
         var _loc10_:SkillTempInfo = null;
         _skillIcon1 = ComponentFactory.Instance.creatCustomObject("outyardTitanRightView.SkillItemIcon1");
         _skillIcon2 = ComponentFactory.Instance.creatCustomObject("outyardTitanRightView.SkillItemIcon2");
         _skillIcon3 = ComponentFactory.Instance.creatCustomObject("outyardTitanRightView.SkillItemIcon3");
         _skillTxt1 = ComponentFactory.Instance.creatComponentByStylename("outyardTitanRightView.skillCountTxt1");
         _skillTxt2 = ComponentFactory.Instance.creatComponentByStylename("outyardTitanRightView.skillCountTxt2");
         _skillTxt3 = ComponentFactory.Instance.creatComponentByStylename("outyardTitanRightView.skillCountTxt3");
         _skillBtn1 = ComponentFactory.Instance.creatComponentByStylename("outyard.titanAddSkillBtn");
         _skillBtn2 = ComponentFactory.Instance.creatComponentByStylename("outyard.titanAddSkillBtn2");
         _skillBtn3 = ComponentFactory.Instance.creatComponentByStylename("outyard.titanAddSkillBtn3");
         _challengeBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.titanChallengeBtn");
         _noteText1 = ComponentFactory.Instance.creatComponentByStylename("outyardTitanPlayerItem.noteText1");
         _noteText2 = ComponentFactory.Instance.creatComponentByStylename("outyardTitanPlayerItem.noteText2");
         _titanBmp1 = ComponentFactory.Instance.creatBitmap("asset.outyard.titanNoteBmp1");
         _titanBmp2 = ComponentFactory.Instance.creatBitmap("asset.outyard.titanNoteBmp2");
         _buffTxtVbox = ComponentFactory.Instance.creatComponentByStylename("outyardTitanRightView.bufftxtVBox");
         addChild(_skillIcon1);
         addChild(_skillIcon2);
         addChild(_skillIcon3);
         addChild(_skillTxt1);
         addChild(_skillTxt2);
         addChild(_skillTxt3);
         addChild(_skillBtn1);
         addChild(_skillBtn2);
         addChild(_skillBtn3);
         addChild(_challengeBtn);
         addChild(_noteText1);
         addChild(_noteText2);
         addChild(_titanBmp1);
         addChild(_titanBmp2);
         addChild(_buffTxtVbox);
         var _loc1_:Array = ConfigInfoManager.instance.getTitanLandSkill();
         _loc7_ = 0;
         while(_loc7_ < _loc1_.length)
         {
            _loc8_ = TempleteManager.instance.getSkillTemplateInfoById(_loc1_[_loc7_]);
            this["_skillIcon" + (_loc7_ + 1)].icon = IconFactory.getTecIconByIcon(_loc8_.Icons);
            this["_skillIcon" + (_loc7_ + 1)].tipData = _loc8_;
            _loc7_++;
         }
         var _loc4_:Array = ConfigInfoManager.instance.getTitanLandBuff();
         var _loc5_:int = int(DragonTitanManager.instance.model.devourTitan.length);
         _loc9_ = 0;
         while(_loc9_ < _loc4_.length)
         {
            _loc6_ = _loc4_[_loc9_].split(",");
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("outyardTitanRightView.bufftxt");
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("outyardTitanRightView.bufftxt");
            _loc10_ = TempleteManager.instance.getSkillTemplateInfoById(_loc6_[1]);
            if(_loc10_ != null)
            {
               if(_loc9_ >= _loc4_.length - 1)
               {
                  _loc3_.htmlText = LanguageMgr.GetTranslation("OutyardTitanRightView.hasTitanNum1",_loc6_[0]);
               }
               else
               {
                  _loc3_.htmlText = LanguageMgr.GetTranslation("OutyardTitanRightView.hasTitanNum",_loc6_[0]);
               }
               _loc2_.htmlText = _loc10_.Description;
               _loc3_.setFrame(1);
               if(_loc5_ >= _loc6_[0])
               {
                  _loc2_.setFrame(2);
               }
               else
               {
                  _loc2_.setFrame(3);
               }
               _buffTxtVbox.addChild(_loc3_);
               _buffTxtVbox.addChild(_loc2_);
               _buffTxtArr.push(_loc3_);
               _buffTxtArr.push(_loc2_);
            }
            _loc9_++;
         }
         _noteText1.text = LanguageMgr.GetTranslation("outyard.event.OutyardEventRightView.noteText1");
         _noteText2.text = LanguageMgr.GetTranslation("outyard.event.OutyardEventRightView.noteText2");
      }
      
      private function addEvent() : void
      {
         _skillBtn1.addEventListener("click",_clickHandler);
         _skillBtn2.addEventListener("click",_clickHandler);
         _skillBtn3.addEventListener("click",_clickHandler);
         _challengeBtn.addEventListener("click",_clickHandler);
      }
      
      private function removeEvent() : void
      {
         _skillBtn1.removeEventListener("click",_clickHandler);
         _skillBtn2.removeEventListener("click",_clickHandler);
         _skillBtn3.removeEventListener("click",_clickHandler);
         _challengeBtn.removeEventListener("click",_clickHandler);
      }
      
      private function _clickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         switch(param1.currentTarget)
         {
            case _skillBtn1:
               buySkillHandler(1);
               break;
            case _skillBtn2:
               buySkillHandler(2);
               break;
            case _skillBtn3:
               buySkillHandler(3);
               break;
            case _challengeBtn:
               if(OutyardManager.instance.titanModel.titanlandMsg.fightLeftCount <= 0)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("OutyardTitanRightView.lessFightLeftCount"));
               }
               else
               {
                  FrameControllerManager.instance.outyardControler._isEnterTitanBattle = true;
                  OutyardManager.instance.OperateTitan(3);
               }
         }
      }
      
      private function buySkillHandler(param1:int) : void
      {
         var _loc2_:Array = ConfigInfoManager.instance.getTitanLandSkillCount();
         var _loc5_:Array = _loc2_[param1 - 1].split(",");
         if(titanlandMsg["skillCount" + param1] >= _loc5_[2])
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("OutyardTitanRightView.skillNum"));
            return;
         }
         SimpleAlertHelper.instance.data = [activeAlertBack,param1,_loc5_[0]];
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc6_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc7_:String = LanguageMgr.GetTranslation("OutyardTitanRightView.addSkillLeftCountTxt",_loc5_[0]);
         SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc3_,_loc4_,true,false,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",param1);
      }
      
      private function activeAlertBack(param1:Boolean, param2:Boolean, param3:int, param4:int) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(!param1)
         {
            return;
         }
         if(param2)
         {
            _loc5_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
         }
         else
         {
            _loc5_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
         }
         if(_loc5_ >= param4)
         {
            _loc6_ = param2 ? 0 : 1;
            OutyardManager.instance.OperateTitan(1,_loc6_,param3);
         }
         else
         {
            RechargeAlertMannager.show();
         }
      }
      
      public function refreshView() : void
      {
         _skillTxt1.text = titanlandMsg.skillCount1 + "";
         _skillTxt2.text = titanlandMsg.skillCount2 + "";
         _skillTxt3.text = titanlandMsg.skillCount3 + "";
      }
      
      private function get titanlandMsg() : TitanlandOpMsg
      {
         return OutyardManager.instance.titanModel.titanlandMsg;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_skillIcon1);
         _skillIcon1 = null;
         ObjectUtils.disposeObject(_skillIcon2);
         _skillIcon2 = null;
         ObjectUtils.disposeObject(_skillIcon3);
         _skillIcon3 = null;
         ObjectUtils.disposeObject(_skillTxt1);
         _skillTxt1 = null;
         ObjectUtils.disposeObject(_skillTxt2);
         _skillTxt2 = null;
         ObjectUtils.disposeObject(_skillTxt3);
         _skillTxt3 = null;
         ObjectUtils.disposeObject(_skillBtn1);
         _skillBtn1 = null;
         ObjectUtils.disposeObject(_skillBtn2);
         _skillBtn2 = null;
         ObjectUtils.disposeObject(_skillBtn3);
         _skillBtn3 = null;
         ObjectUtils.disposeObject(_challengeBtn);
         _challengeBtn = null;
         ObjectUtils.disposeObject(_noteText1);
         _noteText1 = null;
         ObjectUtils.disposeObject(_noteText2);
         _noteText2 = null;
         ObjectUtils.disposeObject(_titanBmp1);
         _titanBmp1 = null;
         ObjectUtils.disposeObject(_titanBmp2);
         _titanBmp2 = null;
         ObjectUtils.disposeObject(_buffTxtVbox);
         _buffTxtVbox = null;
         if(_buffTxtArr)
         {
            while(_buffTxtArr.length)
            {
               ObjectUtils.disposeObject(_buffTxtArr.pop());
            }
         }
         _buffTxtArr = null;
         super.dispose();
      }
   }
}

