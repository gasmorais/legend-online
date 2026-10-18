package theseus.war.view
{
   import bag.events.BagEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.AttributeUtils;
   import mvc.module.theseus.TheseusWarsoulItemInfo;
   import theseus.war.item.TheseusSkillAttII;
   import theseus.war.item.TheseusWarIntensifyCell;
   import theseus.war.item.TheseusWarMetrailCell;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GoodsHelp;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class TheseusWarSKPageView extends Sprite
   {
      
      public var _sk5from:TheseusWarIntensifyCell;
      
      public var _sk5Metrial:TheseusWarMetrailCell;
      
      public var _sk5NameTxt:FilterFrameText;
      
      public var _sk5Btn:IconButton;
      
      private var _hasLenSk:TheseusSkillAttII;
      
      private var _newSkillAtt:TheseusSkillAttII;
      
      private var _helpBtn:BaseButton;
      
      private var _helpTitle:FilterFrameText;
      
      private var _newBtn:BaseButton;
      
      private var _newBtnTxt:FilterFrameText;
      
      public function TheseusWarSKPageView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _sk5from = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.sk5from");
         _sk5Metrial = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.sk5Metrial");
         _sk5NameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.sk5NameTxt");
         _sk5Btn = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.sk5Btn");
         _hasLenSk = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.oldSkillAtt",[1]);
         _newSkillAtt = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.newSkillAtt",[2]);
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.skillHelpBtn");
         _helpTitle = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.skillHelpTxt");
         _newBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.newSkBtn");
         _newBtnTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseus.newSkBtnTxt");
         addChild(_sk5from);
         addChild(_sk5Metrial);
         addChild(_sk5NameTxt);
         addChild(_sk5Btn);
         addChild(_hasLenSk);
         addChild(_newSkillAtt);
         addChild(_helpBtn);
         addChild(_helpTitle);
         addChild(_newBtn);
         addChild(_newBtnTxt);
         _newBtnTxt.text = LanguageMgr.GetTranslation("theseus.war.replaceNewSk");
         _newBtn.enable = false;
         _helpTitle.text = LanguageMgr.GetTranslation("theseus.war.skillHelpTitle");
         _sk5Metrial.isVisalBag = true;
         _sk5Metrial.bagType = 0;
         _sk5Metrial.pos = 0;
         _sk5Metrial.sonType = 763;
         _sk5Metrial.defaultMeTxt = LanguageMgr.GetTranslation("theseus.war.intensifySks");
         TheseussoulManager.Instance.warsoulModel.instensifyFunType = 5;
         _sk5from.funType = 5;
         _sk5from.isNeedMediator = true;
         _sk5Metrial.isNeedMediator = true;
         _sk5Btn.enable = false;
      }
      
      private function initEvent() : void
      {
         _sk5Btn.addEventListener("click",clickHandler);
         NotificationManager.instance.addEventListener("Event.theseusInsPutIn",fromUpdateHandler);
         NotificationManager.instance.addEventListener("Event.theseusInsPutOut",outUpdateHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
         TheseussoulManager.Instance.addEventListener("EVENT_WAR_EQUIP",updateHandler);
         _helpBtn.addEventListener("click",helpHandler);
         _newBtn.addEventListener("click",newBtnHandler);
      }
      
      private function removeEvent() : void
      {
         _sk5Btn.removeEventListener("click",clickHandler);
         NotificationManager.instance.removeEventListener("Event.theseusInsPutIn",fromUpdateHandler);
         NotificationManager.instance.removeEventListener("Event.theseusInsPutOut",outUpdateHandler);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
         TheseussoulManager.Instance.removeEventListener("EVENT_WAR_EQUIP",updateHandler);
         _helpBtn.removeEventListener("click",helpHandler);
         _newBtn.removeEventListener("click",newBtnHandler);
      }
      
      private function newBtnHandler(param1:MouseEvent) : void
      {
         TheseussoulManager.Instance.doWarsoulParam(20,-1,_sk5from.data.id);
      }
      
      private function helpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("theseuswar.skill.helpFrame");
         _loc2_.show();
      }
      
      private function updateHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data);
         if(_sk5from.data && (_loc2_ == 14 || _loc2_ == 20))
         {
            updateUI(_sk5from.data.id);
         }
      }
      
      protected function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc2_:GoodsInfo = param1.info;
         if(_loc2_.bagType == _sk5Metrial.bagType)
         {
            _sk5Metrial.data = _loc2_;
            updateBtnState();
         }
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc2_:GoodsInfo = param1.info;
         if(_loc2_.bagType == _sk5Metrial.bagType)
         {
            _sk5Metrial.data = null;
            updateBtnState();
         }
      }
      
      private function copyGoods(param1:GoodsInfo) : GoodsInfo
      {
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.id = param1.id;
         _loc2_.pos = param1.pos;
         _loc2_.objectId = param1.objectId;
         _loc2_.templateId = param1.templateId;
         _loc2_.isBinds = param1.isBinds;
         _loc2_.validDate = param1.validDate;
         _loc2_.beginDate = param1.beginDate;
         _loc2_.strengthenGrade = param1.strengthenGrade;
         _loc2_.join1 = param1.join1;
         _loc2_.join2 = param1.join2;
         _loc2_.join3 = param1.join3;
         _loc2_.join4 = param1.join4;
         _loc2_.randomSkill1 = param1.randomSkill1;
         _loc2_.randomSkill2 = param1.randomSkill2;
         _loc2_.randomSkill3 = param1.randomSkill3;
         _loc2_.randomSkill4 = param1.randomSkill4;
         _loc2_.randomSkill5 = param1.randomSkill5;
         _loc2_.mouldGrade = param1.mouldGrade;
         _loc2_.blessValue = param1.blessValue;
         return _loc2_;
      }
      
      private function outUpdateHandler(param1:NotificationEvent) : void
      {
         _sk5from.data = null;
         _sk5Btn.enable = false;
         _hasLenSk.setTextValue(null);
         _newSkillAtt.setTextValue(null);
         _sk5NameTxt.text = "";
         cleanSkMetrail();
         TheseussoulManager.Instance.warsoulModel.currInsSelectInfo = null;
      }
      
      private function cleanSkMetrail() : void
      {
         if(_sk5Metrial.data)
         {
            PlayerManager.instance.moveBagToBag(_sk5Metrial.bagType,_sk5Metrial.objectId,_sk5Metrial.pos,1,0,0,1);
         }
         _sk5Metrial.data = null;
      }
      
      private function fromUpdateHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data);
         if(_loc2_ > 0)
         {
            updateUI(_loc2_,true);
         }
      }
      
      private function updateUI(param1:int, param2:Boolean = false) : void
      {
         var _loc5_:SkillTempInfo = null;
         var _loc7_:TheseusWarsoulItemInfo = TheseussoulManager.Instance.warsoulModel.getItemInfo(param1);
         TheseussoulManager.Instance.warsoulModel.currInsSelectInfo = _loc7_;
         _sk5from.data = _loc7_;
         if(param2 && _sk5Metrial.data && _sk5Metrial.data.templateInfo.Property2 != _loc7_.warTempInfo.Rank)
         {
            cleanSkMetrail();
         }
         var _loc4_:String = GoodsHelp.getGoodColorString(_loc7_.warTempInfo.Profile);
         var _loc6_:String = _loc7_.warTempInfo.Name + "+" + _loc7_.strengthen;
         var _loc3_:String = AttributeUtils.getColorStr(_loc6_,_loc4_,false);
         _sk5NameTxt.htmlText = _loc3_;
         if(_loc7_.learnSkill > 0)
         {
            _loc5_ = TempleteManager.instance.getSkillById(_loc7_.learnSkill);
            _hasLenSk.setTextValue(_loc5_.Description);
         }
         else
         {
            _hasLenSk.setTextValue(null);
         }
         if(_loc7_.newLearnSkill > 0)
         {
            _loc5_ = TempleteManager.instance.getSkillById(_loc7_.newLearnSkill);
            _newSkillAtt.setTextValue(_loc5_.Description);
         }
         else
         {
            _newSkillAtt.setTextValue(null);
         }
         updateBtnState();
      }
      
      private function updateBtnState() : void
      {
         if(!_sk5from.data || !_sk5Metrial.data)
         {
            _sk5Btn.enable = false;
         }
         else
         {
            _sk5Btn.enable = true;
         }
         if(_sk5from.data)
         {
            if(_sk5from.data.newLearnSkill > 0)
            {
               _newBtn.enable = true;
            }
            else
            {
               _newBtn.enable = false;
            }
         }
         else
         {
            _newBtn.enable = false;
         }
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         if(_sk5from.data && _sk5Metrial.data)
         {
            TheseussoulManager.Instance.doWarsoulParam(14,-1,_sk5from.data.id);
         }
      }
      
      public function __alertResponse(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(_sk5from.data)
            {
               TheseussoulManager.Instance.doWarsoulParam(14,-1,_sk5from.data.id);
            }
         }
      }
      
      public function moveGoodsBack() : void
      {
         var _loc1_:Array = GoodsManager.instance.getGoodsByBagType(0);
         for each(var _loc2_:GoodsInfo in _loc1_)
         {
            PlayerManager.instance.moveBagToBag(_loc2_.bagType,_loc2_.objectId,_loc2_.pos,1,0,0,1);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         moveGoodsBack();
         if(_sk5from && _sk5from.data)
         {
            _sk5from.data.objectId = 0;
            NotificationManager.instance.sendNotification("Event.theseusInsPutOut",_sk5from.data.id);
         }
         ObjectUtils.disposeObject(_sk5from);
         _sk5from = null;
         ObjectUtils.disposeObject(_sk5Metrial);
         _sk5Metrial = null;
         ObjectUtils.disposeObject(_sk5NameTxt);
         _sk5NameTxt = null;
         ObjectUtils.disposeObject(_newSkillAtt);
         _newSkillAtt = null;
         ObjectUtils.disposeObject(_sk5Btn);
         _sk5Btn = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_newBtn);
         _newBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         TheseussoulManager.Instance.warsoulModel.currInsSelectInfo = null;
      }
   }
}

