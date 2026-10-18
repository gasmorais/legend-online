package child.nursingspirit
{
   import chat.datas.ChatData;
   import com.greensock.TimelineLite;
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildNursingSpiritModel;
   import mvc.module.children.ChildSender;
   import mvc.module.children.NsLifeWheelInfo;
   import utils.LogicUtils;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.filter.UIFilter;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildNSLifeWheelView extends Component
   {
      
      private var back:Bitmap;
      
      private var needPointText:FilterFrameText;
      
      private var pointImage:Image;
      
      private var costText:FilterFrameText;
      
      private var inputBack:ScaleBitmapImage;
      
      private var inputText:FilterFrameText;
      
      private var hasMaterialText:FilterFrameText;
      
      private var keySelectBtn:SelectedButton;
      
      private var keyDescText:FilterFrameText;
      
      private var turnBtn:IconButton;
      
      private var skillIcon:BaseIconView;
      
      private var skillLevelText:FilterFrameText;
      
      private var resiMc:MovieClip;
      
      private var expMc:MovieClip;
      
      private var resultMc:MovieClip;
      
      private var expContiner:Component;
      
      private var expList:Vector.<ChildNsLifeWheelExpItem>;
      
      private var resiContiner:Component;
      
      private var resiList:Vector.<ChildNsLifeWheelResiItem>;
      
      private var hasMaterialCount:int;
      
      private var hasKeyCount:int;
      
      private var prePoint:int;
      
      private var allPoint:int;
      
      private var preSelect:Boolean;
      
      private var lifeWheelInfo:NsLifeWheelInfo;
      
      private var expPosArr:Array = [[256,100],[320,132],[314,208],[254,240],[192,206],[192,130]];
      
      private var resiPosArr:Array = [[242,25],[341,70],[365,176],[302,262],[184,262],[121,178],[142,69]];
      
      private var resultMcArr:Array = [[220,4],[320,50],[345,154],[280,240],[163,240],[100,156],[122,48]];
      
      private var resiFrameIndexArr:Array = [1,6,11,16,22,27,32];
      
      private var gpFrameIndexArr:Array = [1,7,13,19,25,31];
      
      private var resiFrameCount:int;
      
      private var gpFrameCount:int;
      
      public function ChildNSLifeWheelView()
      {
         super();
         initView();
         initExpAndResiView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatBitmap("asset.ChildNSLifeWheelView.ChildNSLifeWheelView");
         expContiner = ComponentFactory.Instance.creatComponentByStylename("ChildNSLifeWheelView.expContiner");
         resiContiner = ComponentFactory.Instance.creatComponentByStylename("ChildNSLifeWheelView.resiContiner");
         needPointText = ComponentFactory.Instance.creatComponentByStylename("ChildNSLifeWheelView.needPointText");
         pointImage = ComponentFactory.Instance.creatComponentByStylename("ChildNSLifeWheelView.pointImage");
         costText = ComponentFactory.Instance.creatComponentByStylename("ChildNSLifeWheelView.costText");
         inputBack = ComponentFactory.Instance.creatComponentByStylename("ChildNSLifeWheelView.inputBack");
         inputText = ComponentFactory.Instance.creatComponentByStylename("ChildNSLifeWheelView.inputText");
         hasMaterialText = ComponentFactory.Instance.creatComponentByStylename("ChildNSLifeWheelView.hasMaterialText");
         keySelectBtn = ComponentFactory.Instance.creatComponentByStylename("ChildNSLifeWheelView.keySelectBtn");
         keyDescText = ComponentFactory.Instance.creatComponentByStylename("ChildNSLifeWheelView.keyDescText");
         turnBtn = ComponentFactory.Instance.creatComponentByStylename("ChildNSLifeWheelView.turnBtn");
         skillIcon = ComponentFactory.Instance.creatCustomObject("ChildNSLifeWheelView.skillIcon");
         skillLevelText = ComponentFactory.Instance.creatComponentByStylename("ChildNSLifeWheelView.skillLevelText");
         resiMc = ComponentFactory.Instance.creatCustomObject("ChildNSLifeWheelView.resiMc");
         expMc = ComponentFactory.Instance.creatCustomObject("ChildNSLifeWheelView.expMc");
         resultMc = ComponentFactory.Instance.creatCustomObject("ChildNSLifeWheelView.resultMc");
         addChild(back);
         addChild(resiContiner);
         addChild(expContiner);
         addChild(resultMc);
         addChild(resiMc);
         addChild(expMc);
         addChild(skillIcon);
         addChild(skillLevelText);
         addChild(needPointText);
         addChild(pointImage);
         addChild(costText);
         addChild(inputBack);
         addChild(inputText);
         addChild(hasMaterialText);
         addChild(keySelectBtn);
         addChild(keyDescText);
         addChild(turnBtn);
         inputText.text = "1";
         resiMc.gotoAndStop(1);
         resiMc.mouseChildren = resiMc.mouseEnabled = false;
         expMc.gotoAndStop(1);
         expMc.mouseChildren = expMc.mouseEnabled = false;
         resultMc.gotoAndStop(1);
         resultMc.mouseChildren = resultMc.mouseEnabled = false;
         resultMc.visible = false;
      }
      
      private function initExpAndResiView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ChildNsLifeWheelExpItem = null;
         var _loc3_:ChildNsLifeWheelResiItem = null;
         expList = new Vector.<ChildNsLifeWheelExpItem>();
         resiList = new Vector.<ChildNsLifeWheelResiItem>();
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("ChildNSLifeWheelView.expItem",[_loc2_]);
            _loc1_.x = expPosArr[_loc2_][0];
            _loc1_.y = expPosArr[_loc2_][1];
            expContiner.addChild(_loc1_);
            expList.push(_loc1_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 7)
         {
            _loc3_ = ComponentFactory.Instance.creatCustomObject("ChildNSLifeWheelView.resiItem",[_loc2_]);
            _loc3_.x = resiPosArr[_loc2_][0];
            _loc3_.y = resiPosArr[_loc2_][1];
            resiContiner.addChild(_loc3_);
            resiList.push(_loc3_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         inputText.addEventListener("change",__inputTextChangeHandler);
         keySelectBtn.addEventListener("click",__keySelectedHandler);
         turnBtn.addEventListener("click",__turnClickHandler);
         MsgMan.addObserver("ChildEvent.CHILD_NS_LIFEWHEEL_LOCK",this,__onLockChangeHandler);
         MsgMan.addObserver("ChildEvent.CHILD_NS_OP_BACK",this,__nsOpBackHandler);
         MsgMan.addObserver("ChildEvent.CHILD_NS_TEMP_SELECT",this,__nsTempSelectHandler);
      }
      
      private function removeEvent() : void
      {
         inputText.removeEventListener("change",__inputTextChangeHandler);
         keySelectBtn.removeEventListener("click",__keySelectedHandler);
         turnBtn.removeEventListener("click",__turnClickHandler);
         MsgMan.removeObserver("ChildEvent.CHILD_NS_LIFEWHEEL_LOCK",this,__onLockChangeHandler);
         MsgMan.removeObserver("ChildEvent.CHILD_NS_OP_BACK",this,__nsOpBackHandler);
         MsgMan.removeObserver("ChildEvent.CHILD_NS_TEMP_SELECT",this,__nsTempSelectHandler);
      }
      
      private function __nsTempSelectHandler(param1:String, param2:Object) : void
      {
         if(ChildManager.instance.curSelectChild)
         {
            refreshView();
         }
      }
      
      private function __onLockChangeHandler(param1:String, param2:Object) : void
      {
         var _loc3_:int = 0;
         nsModel.expLockCount = getLockArr().length;
         prePoint = 0;
         _loc3_ = 0;
         while(_loc3_ < nsModel.expLockCount)
         {
            prePoint = Math.pow(nsModel.expLockCount,2) * 5;
            _loc3_++;
         }
         if(keySelectBtn.selected)
         {
            prePoint = 0;
         }
         allPoint = prePoint * int(inputText.text);
         needPointText.htmlText = LanguageMgr.GetTranslation("ChildNSLifeWheelView.needPointText.text",allPoint);
         pointImage.x = needPointText.x + needPointText.textWidth + 5;
      }
      
      private function __nsSelectChangeHandler(param1:String, param2:Object) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < expList.length)
         {
            expList[_loc3_].isLock = false;
            _loc3_++;
         }
         keySelectBtn.selected = false;
         refreshView();
      }
      
      private function __inputTextChangeHandler(param1:Event) : void
      {
         var _loc2_:int = parseInt(inputText.text);
         if(_loc2_ <= 0)
         {
            inputText.text = "1";
         }
         if(keySelectBtn.selected)
         {
            if(_loc2_ > Math.min(hasKeyCount,hasMaterialCount,999))
            {
               inputText.text = Math.min(hasKeyCount,hasMaterialCount,999) + "";
            }
         }
         else if(_loc2_ > Math.min(hasMaterialCount,999))
         {
            inputText.text = Math.min(hasMaterialCount,999) + "";
         }
         allPoint = prePoint * int(inputText.text);
         needPointText.htmlText = LanguageMgr.GetTranslation("ChildNSLifeWheelView.needPointText.text",allPoint);
         pointImage.x = needPointText.x + needPointText.textWidth + 5;
      }
      
      private function __keySelectedHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(hasKeyCount <= 0)
         {
            keySelectBtn.selected = preSelect;
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("PetHallowsRightSkillView.train.noGoodsAlert"));
            return;
         }
         nsModel.isKeySelected = keySelectBtn.selected;
         _loc2_ = 0;
         while(_loc2_ < expList.length)
         {
            if(keySelectBtn.selected && _loc2_ != expList.length - 1)
            {
               expList[_loc2_].isLock = true;
            }
            else
            {
               expList[_loc2_].isLock = false;
            }
            _loc2_++;
         }
         __inputTextChangeHandler(null);
      }
      
      private function __turnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(hasMaterialCount < int(inputText.text))
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildNSLifeWheelView.noMaterial.alert"));
            return;
         }
         if(allPoint > 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc3_ = LanguageMgr.GetTranslation("childNsLifeWheel.lock.costContent",allPoint,getLockArr().length);
            SharedManagerHelper.ins.needAlert("childNsLifeWheel.lock.alert",turnLifeWheelResultHandler,_loc2_,_loc3_,"");
         }
         else
         {
            setEnable(false);
            ChildSender.nsLifeWheelTurn(nsModel.selectedNsChild.childId,0,getLockStr(),keySelectBtn.selected,int(inputText.text));
         }
      }
      
      private function turnLifeWheelResultHandler(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1)
         {
            _loc2_ = int(playerModel.playerInfo.allPoint);
         }
         else
         {
            _loc2_ = int(playerModel.playerInfo.point);
         }
         if(_loc2_ >= allPoint)
         {
            setEnable(false);
            _loc3_ = param1 ? 2 : 1;
            ChildSender.nsLifeWheelTurn(nsModel.selectedNsChild.childId,_loc3_,getLockStr(),keySelectBtn.selected,int(inputText.text));
         }
         else
         {
            RechargeAlertMannager.show();
         }
      }
      
      private function __nsOpBackHandler(param1:String, param2:Object) : void
      {
         var _loc4_:int = 0;
         var _loc9_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TimelineLite = null;
         var _loc7_:int = 0;
         var _loc3_:TimelineLite = null;
         var _loc8_:int = param2 as int;
         if(_loc8_ != 35)
         {
            return;
         }
         if(nsModel.isSuccess)
         {
            gpFrameCount = gpFrameIndexArr[nsModel.gpIndex];
            resiFrameCount = resiFrameIndexArr[nsModel.resiIndex];
            _loc4_ = expMc.currentFrame;
            _loc9_ = resiMc.currentFrame;
            _loc5_ = _loc4_ > 18 ? 1.2 : 1.8;
            _loc6_ = new TimelineLite({"onComplete":null});
            _loc6_.append(TweenMax.to(expMc,_loc5_,{"frame":37}));
            _loc5_ = gpFrameCount > 18 ? 1.8 : 1.2;
            _loc6_.append(TweenMax.fromTo(expMc,_loc5_,{"frame":1},{"frame":gpFrameCount}));
            _loc6_.play();
            _loc6_ = null;
            _loc7_ = _loc9_ > 18 ? 1.2 : 1.8;
            _loc3_ = new TimelineLite({"onComplete":mcStopHandler});
            _loc3_.append(TweenMax.to(resiMc,_loc7_,{"frame":37}));
            _loc7_ = resiFrameCount > 18 ? 1.8 : 1.2;
            _loc3_.append(TweenMax.fromTo(resiMc,_loc7_,{"frame":1},{"frame":resiFrameCount}));
            _loc3_.play();
            _loc3_ = null;
         }
         else
         {
            setEnable(true);
            refreshView();
         }
      }
      
      private function mcStopHandler() : void
      {
         if(!resultMc)
         {
            return;
         }
         resultMc.x = resultMcArr[nsModel.resiIndex][0];
         resultMc.y = resultMcArr[nsModel.resiIndex][1];
         resultMc.visible = true;
         resultMc.gotoAndPlay(1);
         resultMc.addFrameScript(resultMc.totalFrames - 1,function():void
         {
            resultMc.stop();
            setEnable(true);
            showChatMsg();
            refreshView();
         });
      }
      
      private function showChatMsg() : void
      {
         if(chatContent == null || chatContent == "")
         {
            return;
         }
         var _loc1_:ChatData = ObjectPool.getObject(ChatData) as ChatData;
         if(_loc1_)
         {
            _loc1_.channel = 3;
            _loc1_.msg = chatContent;
            _loc1_.commit();
            NotificationManager.instance.sendNotification("ADD_CHAT",_loc1_);
            MessageTipManager.instance().show(chatContent);
         }
      }
      
      private function get chatContent() : String
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = "";
         var _loc4_:Array = nsModel.results.split(",");
         _loc1_ = 0;
         while(_loc1_ < _loc4_.length)
         {
            if(int(_loc4_[_loc1_]) != 0)
            {
               _loc2_ = _loc1_ + 1;
               _loc3_ += LanguageMgr.GetTranslation("planesRewardTip.resistance.typeText" + _loc2_) + LanguageMgr.GetTranslation("task.view.TaskRewardItem.iconTips01") + "+" + int(_loc4_[_loc1_]) + ",";
            }
            _loc1_++;
         }
         return _loc3_.substring(0,_loc3_.lastIndexOf(","));
      }
      
      private function setEnable(param1:Boolean) : void
      {
         turnBtn.enable = param1;
         KeyBoardRegister.instance.keyEnable = param1;
         MsgMan.notifyObserver("ChildEvent.CHILD_NS_LIFEWHEEL_BTNENABLE",param1);
      }
      
      public function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(212009);
         hasMaterialCount = GoodsManager.instance.getGoodsNumByTempId(212009);
         var _loc5_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(212010);
         hasKeyCount = GoodsManager.instance.getGoodsNumByTempId(212010);
         costText.text = LanguageMgr.GetTranslation("ChildNSLifeWheelView.costText.text",_loc1_.TemplateName);
         hasMaterialText.htmlText = LanguageMgr.GetTranslation("ChildNSLifeWheelView.hasMaterialText.text",_loc1_.TemplateName,hasMaterialCount);
         keyDescText.htmlText = LanguageMgr.GetTranslation("ChildNSLifeWheelView.keyDescText.text",_loc5_.TemplateName,hasKeyCount);
         if(hasKeyCount <= 0)
         {
            keySelectBtn.selected = false;
         }
         inputText.x = inputBack.x = costText.x + costText.textWidth + 5;
         pointImage.x = needPointText.x + needPointText.textWidth + 5;
         preSelect = keySelectBtn.selected;
         nsModel.isKeySelected = keySelectBtn.selected;
         lifeWheelInfo = nsModel.selectedNsChild.nursingSpiritInfo.lifeWheelInfo;
         if(lifeWheelInfo.activeSkillId != 0)
         {
            _loc2_ = int(lifeWheelInfo.activeSkillId);
            skillIcon.filters = [];
         }
         else
         {
            _loc2_ = int(nsModel.getShowSkillTempId(lifeWheelInfo));
            skillIcon.filters = [UIFilter.getGrayFilter()];
         }
         var _loc4_:SkillTempInfo = TempleteManager.instance.getSkillById(_loc2_);
         var _loc6_:String = IconFactory.getCommonIconPath(_loc4_.Icons);
         if(skillIcon.icon != _loc6_)
         {
            skillIcon.icon = _loc6_;
         }
         skillIcon.tipData = _loc4_;
         skillLevelText.text = LanguageMgr.GetTranslation("public.level2",_loc4_.Grades);
         _loc3_ = 0;
         while(_loc3_ < expList.length)
         {
            expList[_loc3_].refreshView();
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < resiList.length)
         {
            resiList[_loc3_].refreshView();
            _loc3_++;
         }
         __onLockChangeHandler(null,null);
      }
      
      private function getLockArr() : Array
      {
         var _loc1_:int = 0;
         var _loc2_:Array = [];
         _loc1_ = 0;
         while(_loc1_ < expList.length)
         {
            if(expList[_loc1_].isLock)
            {
               _loc2_.push(_loc1_);
            }
            _loc1_++;
         }
         return _loc2_;
      }
      
      private function getLockStr() : String
      {
         var _loc1_:int = 0;
         var _loc2_:String = "";
         _loc1_ = 0;
         while(_loc1_ < getLockArr().length)
         {
            _loc2_ += getLockArr()[_loc1_] + ",";
            _loc1_++;
         }
         return _loc2_.substring(0,_loc2_.lastIndexOf(","));
      }
      
      private function get nsModel() : ChildNursingSpiritModel
      {
         return ChildManager.instance.nsModel;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(expContiner);
         expContiner = null;
         ObjectUtils.disposeObject(resiContiner);
         resiContiner = null;
         ObjectUtils.disposeObject(needPointText);
         needPointText = null;
         ObjectUtils.disposeObject(pointImage);
         pointImage = null;
         ObjectUtils.disposeObject(costText);
         costText = null;
         ObjectUtils.disposeObject(inputBack);
         inputBack = null;
         ObjectUtils.disposeObject(inputText);
         inputText = null;
         ObjectUtils.disposeObject(hasMaterialText);
         hasMaterialText = null;
         ObjectUtils.disposeObject(keySelectBtn);
         keySelectBtn = null;
         ObjectUtils.disposeObject(keyDescText);
         keyDescText = null;
         ObjectUtils.disposeObject(turnBtn);
         turnBtn = null;
         ObjectUtils.disposeObject(skillIcon);
         skillIcon = null;
         ObjectUtils.disposeObject(skillLevelText);
         skillLevelText = null;
         ObjectUtils.disposeViolentMc(resiMc);
         resiMc = null;
         ObjectUtils.disposeViolentMc(expMc);
         expMc = null;
         ObjectUtils.disposeViolentMc(resultMc);
         resultMc = null;
         LogicUtils.disposeDisplayCollection(expList);
         expList = null;
         LogicUtils.disposeDisplayCollection(resiList);
         resiList = null;
         super.dispose();
      }
   }
}

