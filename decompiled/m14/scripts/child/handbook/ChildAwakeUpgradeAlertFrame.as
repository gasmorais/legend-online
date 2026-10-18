package child.handbook
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.armyII.ArmyPawn;
   import mvc.module.children.ChildCollectInfo;
   import mvc.module.children.ChildModel;
   import mvc.module.children.ChildSender;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.datas.templates.ChildTypeTempInfo;
   import yishi.datas.templates.PawnSpecialTempInfo;
   import yishi.datas.templates.PawnTemplate;
   import yishi.manager.ArmyManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.base.StarBar;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildAwakeUpgradeAlertFrame extends Frame
   {
      
      private var titleContentText:FilterFrameText;
      
      private var curText:FilterFrameText;
      
      private var nextText:FilterFrameText;
      
      private var curBox:StarBar;
      
      private var nextBox:StarBar;
      
      private var costStoneText:FilterFrameText;
      
      private var hasStoneText:FilterFrameText;
      
      private var condictionText:FilterFrameText;
      
      private var awakeBtn:IconButton;
      
      private var upgradeBtn:IconButton;
      
      private var alertText:FilterFrameText;
      
      private const starCount:int = 5;
      
      private var _data:ChildTempInfo;
      
      private var _curTypeTemp:ChildTypeTempInfo;
      
      private var _nextTypeTemp:ChildTypeTempInfo;
      
      private var _collectInfo:ChildCollectInfo;
      
      private var _hasStoneCount:int;
      
      private var _needStoneCount:int;
      
      private var isReached:Boolean = true;
      
      public function ChildAwakeUpgradeAlertFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleContentText = ComponentFactory.Instance.creatComponentByStylename("ChildAwakeAlertFrame.titleContentText");
         curText = ComponentFactory.Instance.creatComponentByStylename("ChildAwakeAlertFrame.curText");
         nextText = ComponentFactory.Instance.creatComponentByStylename("ChildAwakeAlertFrame.nextText");
         costStoneText = ComponentFactory.Instance.creatComponentByStylename("ChildAwakeAlertFrame.costStoneText");
         hasStoneText = ComponentFactory.Instance.creatComponentByStylename("ChildAwakeAlertFrame.hasStoneText");
         condictionText = ComponentFactory.Instance.creatComponentByStylename("ChildAwakeAlertFrame.condictionText");
         awakeBtn = ComponentFactory.Instance.creatComponentByStylename("ChildAwakeAlertFrame.awakeBtn");
         upgradeBtn = ComponentFactory.Instance.creatComponentByStylename("ChildAwakeAlertFrame.upgradeBtn");
         alertText = ComponentFactory.Instance.creatComponentByStylename("ChildAwakeAlertFrame.alertText");
         curBox = new StarBar(5,0,"asset.ChildHandBookItem.EmptyStar","asset.ChildHandBookItem.FullStar");
         curBox.mouseEnabled = curBox.mouseChildren = false;
         curBox.x = 10;
         curBox.y = 25;
         nextBox = new StarBar(5,0,"asset.ChildHandBookItem.EmptyStar","asset.ChildHandBookItem.FullStar");
         nextBox.mouseEnabled = nextBox.mouseChildren = false;
         nextBox.x = 180;
         nextBox.y = 25;
         addToContent(titleContentText);
         addToContent(curBox);
         addToContent(nextBox);
         addToContent(curText);
         addToContent(nextText);
         addToContent(costStoneText);
         addToContent(hasStoneText);
         addToContent(condictionText);
         addToContent(awakeBtn);
         addToContent(upgradeBtn);
         addToContent(alertText);
         titleContentText.text = LanguageMgr.GetTranslation("ChildAwakeAlertFrame.titleContentText.text");
         alertText.text = LanguageMgr.GetTranslation("ChildAwakeAlertFrame.alertText.text");
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__responseHandler);
         awakeBtn.addEventListener("click",__awakeUpgradeBtnHandler);
         upgradeBtn.addEventListener("click",__awakeUpgradeBtnHandler);
         MsgMan.addObserver("ChildEvent.CHILD_INFO",this,__updateAwakeUpgradeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         awakeBtn.removeEventListener("click",__awakeUpgradeBtnHandler);
         upgradeBtn.removeEventListener("click",__awakeUpgradeBtnHandler);
         MsgMan.removeObserver("ChildEvent.CHILD_INFO",this,__updateAwakeUpgradeHandler);
      }
      
      private function __awakeUpgradeBtnHandler(param1:MouseEvent) : void
      {
         if(_hasStoneCount < _needStoneCount)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildAwakeAlertFrame.noStone.alert"));
            return;
         }
         if(!isReached)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildAwakeAlertFrame.pawnNoReached.alert"));
            return;
         }
         ChildSender.awakeUpgradeChild(_data.JobType);
      }
      
      private function __updateAwakeUpgradeHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc6_:String = null;
         var _loc1_:ArmyPawn = null;
         var _loc2_:PawnTemplate = null;
         var _loc4_:PawnSpecialTempInfo = null;
         var _loc5_:String = null;
         var _loc3_:int = 0;
         _collectInfo = model.getChildCollecInfoByType(_data.JobType);
         if(!_collectInfo)
         {
            return;
         }
         _curTypeTemp = TempleteManager.instance.childTypeTemplateCate.getTemplateByJobAndSoulWakeGrades(_data.JobType,_collectInfo.soulWakes);
         _nextTypeTemp = TempleteManager.instance.childTypeTemplateCate.getTemplateByJobAndSoulWakeGrades(_data.JobType,_collectInfo.soulWakes + 1);
         if(!_nextTypeTemp)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildHandBookItem.awakeUpgrade.isFull"));
            dispose();
            return;
         }
         _needStoneCount = _nextTypeTemp.NeedItemCount;
         var _loc7_:Array = _nextTypeTemp.NeedArmyPawnTempIds.split(",");
         if(!_curTypeTemp)
         {
            _loc6_ = LanguageMgr.GetTranslation("ChildAwakeAlertFrame.condictionText.text0");
            awakeBtn.visible = true;
            curText.htmlText = LanguageMgr.GetTranslation("ChildAwakeAlertFrame.nextText.text",0);
            costStoneText.htmlText = LanguageMgr.GetTranslation("ChildAwakeAlertFrame.costStoneText.text0",_needStoneCount);
         }
         else
         {
            _loc6_ = LanguageMgr.GetTranslation("ChildAwakeAlertFrame.condictionText.text1");
            upgradeBtn.visible = true;
            curText.htmlText = LanguageMgr.GetTranslation("ChildAwakeAlertFrame.nextText.text",_curTypeTemp.Percentage);
            costStoneText.htmlText = LanguageMgr.GetTranslation("ChildAwakeAlertFrame.costStoneText.text1",_needStoneCount);
         }
         _loc3_ = 0;
         while(_loc3_ < _loc7_.length)
         {
            _loc2_ = TempleteManager.instance.pawnTemplateCate.getTemplateByID(_loc7_[_loc3_]);
            if(_loc2_)
            {
               _loc1_ = ArmyManager.instance.getCasernPawn(_loc2_.SonType);
               _loc4_ = TempleteManager.instance.pawnSpecialTemplateCate.getTemplateByID(int(_loc1_.specialAbility));
               _loc5_ = LanguageMgr.GetTranslation("public.level2",_loc2_.Level);
               _loc6_ += _loc2_.PawnName + " " + _loc5_ + ",";
               if(_loc1_.templateInfo.Level < _loc2_.Level)
               {
                  isReached = false;
               }
               if(_nextTypeTemp.NeedSpecialsTempId > 0)
               {
                  if(!_loc4_ || _loc4_.Grades < _nextTypeTemp.NeedSpecialsTempId)
                  {
                     isReached = false;
                  }
               }
            }
            _loc3_++;
         }
         if(_nextTypeTemp.NeedSpecialsTempId > 0)
         {
            _loc5_ = LanguageMgr.GetTranslation("public.level2",_nextTypeTemp.NeedSpecialsTempId);
            _loc6_ += LanguageMgr.GetTranslation("ChildAwakeAlertFrame.condictionText.addText") + " " + _loc5_;
         }
         else
         {
            _loc6_ = _loc6_.substring(0,_loc6_.lastIndexOf(","));
         }
         condictionText.htmlText = _loc6_;
         if(isReached)
         {
            condictionText.setFrame(2);
         }
         else
         {
            condictionText.setFrame(1);
         }
         curBox.visible = true;
         nextBox.visible = true;
         curBox.progress = _collectInfo.soulWakes;
         nextBox.progress = _collectInfo.soulWakes + 1;
         nextText.htmlText = LanguageMgr.GetTranslation("ChildAwakeAlertFrame.nextText.text",_nextTypeTemp.Percentage);
         _hasStoneCount = GoodsManager.instance.getGoodsNumInAllBySonType(620);
         hasStoneText.htmlText = LanguageMgr.GetTranslation("ChildAwakeAlertFrame.hasStoneText.text",_hasStoneCount);
      }
      
      public function set data(param1:ChildTempInfo) : void
      {
         clean();
         _data = param1;
         if(!_data)
         {
            return;
         }
         refreshView();
      }
      
      private function clean() : void
      {
         curBox.visible = false;
         nextBox.visible = false;
         awakeBtn.visible = false;
         upgradeBtn.visible = false;
         curText.text = "";
         nextText.text = "";
         costStoneText.text = "";
         condictionText.text = "";
         hasStoneText.text = "";
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("public.prompt");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(titleContentText);
         titleContentText = null;
         ObjectUtils.disposeObject(curBox);
         curBox = null;
         ObjectUtils.disposeObject(nextBox);
         nextBox = null;
         ObjectUtils.disposeObject(curText);
         curText = null;
         ObjectUtils.disposeObject(nextText);
         nextText = null;
         ObjectUtils.disposeObject(costStoneText);
         costStoneText = null;
         ObjectUtils.disposeObject(hasStoneText);
         hasStoneText = null;
         ObjectUtils.disposeObject(condictionText);
         condictionText = null;
         ObjectUtils.disposeObject(awakeBtn);
         awakeBtn = null;
         ObjectUtils.disposeObject(upgradeBtn);
         upgradeBtn = null;
         ObjectUtils.disposeObject(alertText);
         alertText = null;
         super.dispose();
      }
   }
}

