package emailII.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.EmailEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.MopupManager;
   import map.internals.constant.MapGrid;
   import map.internals.data.MapInitData;
   import mvc.controler.EmailControler;
   import mvc.module.emailII.EmailInfo;
   import mvc.module.emailII.EmailModel;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.utils.WorldBossHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class ReadBattleReportView extends Sprite implements Disposeable
   {
      
      private var _line:BitmapData;
      
      private var _background:MutipleImage;
      
      private var _timeText:FilterFrameText;
      
      private var _enemyName:FilterFrameText;
      
      private var _posTxt:FilterFrameText;
      
      private var _contentText:FilterFrameText;
      
      private var _closeBtn:SelectedCheckButton;
      
      private var _data:EmailInfo;
      
      private var _control:EmailControler;
      
      private var _model:EmailModel;
      
      private var _self:BattleReportItem;
      
      private var _enemy:BattleReportItem;
      
      public function ReadBattleReportView(param1:EmailControler, param2:EmailModel)
      {
         super();
         _control = param1;
         _model = param2;
         init();
         initEvent();
      }
      
      private function init() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Bitmap = null;
         _background = ComponentFactory.Instance.creatComponentByStylename("email.ReportBack");
         _timeText = ComponentFactory.Instance.creatComponentByStylename("email.ReportTimeTxt");
         _enemyName = ComponentFactory.Instance.creatComponentByStylename("email.ReportPosTxt");
         _posTxt = ComponentFactory.Instance.creatComponentByStylename("email.ReportPosTxt1");
         _contentText = ComponentFactory.Instance.creatComponentByStylename("email.ReportContentTxt");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("email.ReportClose");
         _line = ComponentFactory.Instance.creatBitmapData("asset.core.WriteEmailLine");
         _self = ComponentFactory.Instance.creatCustomObject("email.BattleReportItem1",["true"]);
         _enemy = ComponentFactory.Instance.creatCustomObject("email.BattleReportItem2");
         _closeBtn.text = LanguageMgr.GetTranslation("public.close");
         addChild(_background);
         _loc2_ = 0;
         while(_loc2_ < 14)
         {
            _loc1_ = new Bitmap(_line);
            _loc1_.x = 5;
            _loc1_.y = _loc2_ * 24 + 35;
            _loc1_.alpha = 0.7;
            addChild(_loc1_);
            _loc2_++;
         }
         addChild(_timeText);
         addChild(_enemyName);
         addChild(_posTxt);
         addChild(_contentText);
         addChild(_closeBtn);
         addChild(_self);
         addChild(_enemy);
         refreshData();
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeObject(_line);
         ObjectUtils.disposeAllChildren(this);
         _line = null;
         _data = null;
      }
      
      private function initEvent() : void
      {
         _closeBtn.addEventListener("click",__closeHandler);
         _model.addEventListener("DATA_EMAIL_DELETE",__deleteHandler);
         _model.addEventListener("DATA_EMAIL_UPDATE",__updateHandler);
         _posTxt.addEventListener("click",__onPosClickHandler);
      }
      
      private function removeEvent() : void
      {
         _closeBtn.removeEventListener("click",__closeHandler);
         _model.removeEventListener("DATA_EMAIL_DELETE",__deleteHandler);
         _model.removeEventListener("DATA_EMAIL_UPDATE",__updateHandler);
         _posTxt.removeEventListener("click",__onPosClickHandler);
      }
      
      private function __updateHandler(param1:EmailEvent) : void
      {
         if(_model.emailType != 3)
         {
            return;
         }
         if(_model.emailType == 3)
         {
            refreshView();
            _model.dispatchEvent(new EmailEvent("NEW_BATTLEREPORT_CHANGE"));
         }
      }
      
      private function __deleteHandler(param1:EmailEvent) : void
      {
         if(_model.emailType != 3)
         {
            return;
         }
         if(_data)
         {
            if(param1.list.indexOf(_data.Id) >= 0)
            {
               _control.closeReadFrame();
            }
         }
      }
      
      public function refreshData() : void
      {
         _data = _model.currentReadEmail;
         refreshView();
      }
      
      private function __closeHandler(param1:MouseEvent) : void
      {
         _control.closeReadFrame();
      }
      
      private function getContent() : String
      {
         if(_data.report.camp == 1)
         {
            return LanguageMgr.GetTranslation("emailII.view.ReadBattleReportView.content01");
         }
         return LanguageMgr.GetTranslation("emailII.view.ReadBattleReportView.content02");
      }
      
      private function refreshView() : void
      {
         if(_data && _data.report)
         {
            if(_data.report.type == 2)
            {
               _timeText.text = _data.report.time;
               _enemyName.text = "";
               _posTxt.text = "";
               _contentText.text = _data.report.content;
               _contentText.height = _contentText.textHeight + 2;
               _self.data = null;
               _enemy.data = null;
               _self.visible = false;
               _enemy.visible = false;
               _posTxt.mouseEnabled = false;
            }
            else
            {
               _timeText.text = _data.report.time;
               _enemyName.text = _data.report.playerName;
               _posTxt.x = _enemyName.x + _enemyName.textWidth + 10;
               _posTxt.htmlText = "<a href =\'event: \'>(" + MapGrid.getPositionString(_data.report.pos) + ")" + _data.report.mapName + "</a>";
               _contentText.text = getContent();
               _contentText.height = _contentText.textHeight + 2;
               _self.data = _data.report;
               _enemy.data = _data.report;
               _self.visible = true;
               _enemy.visible = true;
               _posTxt.mouseEnabled = true;
            }
         }
         else
         {
            _timeText.text = "";
            _enemyName.text = "";
            _posTxt.text = "";
            _contentText.text = "";
            _self.data = null;
            _enemy.data = null;
            _self.visible = true;
            _enemy.visible = true;
         }
      }
      
      private function __onPosClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(_data.report.mapId != PlayerManager.instance.currentPlayerModel.mapNodeInfo["info"].mapId)
         {
            _loc2_ = LanguageMgr.GetTranslation("emailII.view.ReadBattleReportView.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(MopupManager.instance.model.isMopup)
         {
            _loc2_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            MessageTipManager.instance().show(WorldBossHelper.getCampaignTips());
            return;
         }
         if(SceneManager.instance.currentType == "SPACE_SCENE")
         {
            _loc2_ = LanguageMgr.GetTranslation("emailII.view.ReadBattleReportView.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc3_:int = int(MapGrid.getConvertWidth(int(_data.report.pos.split(",")[0])));
         var _loc4_:int = int(MapGrid.getConvertWidth(int(_data.report.pos.split(",")[1])));
         var _loc6_:Point = new Point(_loc3_ * 50,_loc4_ * 50);
         var _loc5_:MapInitData = new MapInitData();
         _loc5_.mapTempInfo = TempleteManager.instance.mapTemplateCate.getTemplateByID(_data.report.mapId);
         _loc5_.targetPoint = _loc6_;
         SceneManager.instance.setScene("OUTER_CITY_SCENE",_loc5_,true);
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

