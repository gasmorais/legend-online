package colosseum.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.colosseum.ColosseumEventData;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerInfoManager;
   import yishi.manager.PlayerManager;
   
   public class ColosseumEventItem extends Sprite implements Disposeable
   {
      
      private var _icon:ScaleFrameImage;
      
      private var _timeTxt:FilterFrameText;
      
      private var _attackCon:Sprite;
      
      private var _attackTxt:FilterFrameText;
      
      private var _txt1:FilterFrameText;
      
      private var _defebceCon:Sprite;
      
      private var _defenceTxt:FilterFrameText;
      
      private var _restuleTxt:FilterFrameText;
      
      private var _rankTxt:FilterFrameText;
      
      private var _data:ColosseumEventData;
      
      public function ColosseumEventItem()
      {
         super();
         initView();
         refreshPos();
      }
      
      private function initView() : void
      {
         _icon = ComponentFactory.Instance.creatComponentByStylename("colosseum.EventIcon");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("colosseum.EventTimeTxt");
         _attackCon = new Sprite();
         _attackCon.buttonMode = true;
         _attackCon.y = 1;
         _attackTxt = ComponentFactory.Instance.creatComponentByStylename("colosseum.EventAttackTxt");
         _txt1 = ComponentFactory.Instance.creatComponentByStylename("colosseum.EventDescribeTxt");
         _defebceCon = new Sprite();
         _defebceCon.y = 1;
         _defebceCon.buttonMode = true;
         _defenceTxt = ComponentFactory.Instance.creatComponentByStylename("colosseum.EventDefenceTxt");
         _restuleTxt = ComponentFactory.Instance.creatComponentByStylename("colosseum.EventResultTxt");
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("colosseum.EventRankTxt");
         addChild(_icon);
         _icon.setFrame(1);
         addChild(_timeTxt);
         _attackCon.addChild(_attackTxt);
         addChild(_attackCon);
         addChild(_txt1);
         _defebceCon.addChild(_defenceTxt);
         addChild(_defebceCon);
         addChild(_restuleTxt);
         addChild(_rankTxt);
         _attackCon.mouseChildren = _defebceCon.mouseChildren = false;
      }
      
      private function removeEvent() : void
      {
         _attackCon.removeEventListener("click",__clickHandler);
         _defebceCon.removeEventListener("click",__clickHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         var _loc2_:ThaneInfo = new ThaneInfo();
         _loc2_.userId = _data.tarUserId;
         _loc2_.nickName = _data.tarNickName;
         _loc2_.playerOrdeInfo.gpOrder = _data.tarOrder;
         _loc2_.grades = _data.tarGrade;
         _loc2_.gp = _data.tarGp;
         _loc2_.templateId = _data.tarTemplateId;
         PlayerInfoManager.instance.show(_loc2_);
      }
      
      private function refreshPos() : void
      {
         _attackCon.x = _timeTxt.x + _timeTxt.textWidth;
         _txt1.x = _attackCon.x + _attackCon.width - 2;
         _defebceCon.x = _txt1.x + _txt1.textWidth;
         _restuleTxt.x = _defebceCon.x + _defebceCon.width;
         _rankTxt.x = _restuleTxt.x + _restuleTxt.textWidth;
      }
      
      private function refreshView() : void
      {
         _timeTxt.text = LanguageMgr.GetTranslation("colosseum.view.ColosseumEventItem.time") + getTimeString();
         _txt1.text = LanguageMgr.GetTranslation("colosseum.view.ColosseumEventItem.txt1");
         _defebceCon.mouseEnabled = _attackCon.mouseEnabled = false;
         initRestult();
         if(_data.isAttack)
         {
            _icon.setFrame(1);
            _attackTxt.text = LanguageMgr.GetTranslation("colosseum.view.ColosseumEventItem.txt2");
            _defenceTxt.htmlText = "<font color=\'#f0f695\'><u>" + _data.tarNickName + "<u/></font>";
            _defebceCon.addEventListener("click",__clickHandler);
            _defebceCon.mouseEnabled = true;
         }
         else
         {
            _icon.setFrame(2);
            _attackTxt.htmlText = "<font color=\'#f0f695\'><u>" + _data.tarNickName + "</a><u/></font>";
            _defenceTxt.text = LanguageMgr.GetTranslation("colosseum.view.ColosseumEventItem.txt2");
            _attackCon.addEventListener("click",__clickHandler);
            _attackCon.mouseEnabled = true;
         }
         refreshPos();
      }
      
      private function initRestult() : void
      {
         if(_data.forward == 0)
         {
            _rankTxt.text = LanguageMgr.GetTranslation("colosseum.view.ColosseumEventItem.rank01");
         }
         else if(_data.forward > 0)
         {
            _rankTxt.text = LanguageMgr.GetTranslation("colosseum.view.ColosseumEventItem.rank02") + _data.curRankResult;
         }
         else
         {
            _rankTxt.text = LanguageMgr.GetTranslation("colosseum.view.ColosseumEventItem.rank03") + _data.curRankResult;
         }
         if(_data.restult == 1)
         {
            _restuleTxt.htmlText = LanguageMgr.GetTranslation("colosseum.view.ColosseumEventItem.restule01");
         }
         else
         {
            _restuleTxt.htmlText = LanguageMgr.GetTranslation("colosseum.view.ColosseumEventItem.restule02");
         }
      }
      
      private function getTimeString() : String
      {
         var _loc1_:Number = serverTime * 1000 - _data.logDate.getTime();
         if(_loc1_ / 604800000 > 1)
         {
            return LanguageMgr.GetTranslation("colosseum.view.colosseum.view.ColosseumEventItem.time01");
         }
         if(_loc1_ / 259200000 > 1)
         {
            return LanguageMgr.GetTranslation("colosseum.view.colosseum.view.ColosseumEventItem.time02");
         }
         if(_loc1_ / 43200000 > 1)
         {
            return LanguageMgr.GetTranslation("colosseum.view.colosseum.view.ColosseumEventItem.time03");
         }
         if(_loc1_ / 3600000 > 1)
         {
            return LanguageMgr.GetTranslation("colosseum.view.colosseum.view.ColosseumEventItem.time04");
         }
         return LanguageMgr.GetTranslation("colosseum.view.colosseum.view.ColosseumEventItem.time05");
      }
      
      private function get serverTime() : Number
      {
         return PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function set data(param1:ColosseumEventData) : void
      {
         _data = param1;
         refreshView();
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_attackCon);
         _attackCon = null;
         ObjectUtils.disposeObject(_attackTxt);
         _attackTxt = null;
         ObjectUtils.disposeObject(_txt1);
         _txt1 = null;
         ObjectUtils.disposeObject(_defebceCon);
         _defebceCon = null;
         ObjectUtils.disposeObject(_defenceTxt);
         _defenceTxt = null;
         ObjectUtils.disposeObject(_restuleTxt);
         _restuleTxt = null;
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeAllChildren(this);
         _data = null;
      }
   }
}

