package consortia.view.crossguild.war
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.crossguild.CrossGuildModel;
   import mvc.module.crossguild.CrossGuildRecordInfo;
   import mvc.module.crossguild.CrossGuildTowerInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.CrossGuildManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.view.base.ProgressCommon;
   import yishi.view.community.BaseIconView;
   
   public class CrossGuildTowerDetailFrame extends Frame implements IManualSize
   {
      
      private var _recordText:FilterFrameText;
      
      private var _troubleText:FilterFrameText;
      
      private var _fightText:FilterFrameText;
      
      private var _detailBack:MutipleImage;
      
      private var _bloodBar:ProgressCommon;
      
      private var _bufferBox:HBox;
      
      private var _sealBox:HBox;
      
      private var maxTroubleCount:int;
      
      private var _data:CrossGuildTowerInfo;
      
      private var baseInfo:CrossGuildTowerInfo;
      
      public function CrossGuildTowerDetailFrame(param1:CrossGuildTowerInfo)
      {
         super();
         baseInfo = param1;
         initView();
         addEvent();
         CrossGuildManager.instance.sendCrossGuildTowerDetail(baseInfo.teamId,baseInfo.towerId);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,375,425);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _recordText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildTowerDetailFrame.recordText");
         _troubleText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildTowerDetailFrame.troubleText");
         _fightText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildTowerDetailFrame.fightText");
         _detailBack = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildTowerDetailFrame.detailBack");
         _bloodBar = ComponentFactory.Instance.creatComponentByStylename("CrossGuildTowerDetailFrame.bloodBar");
         _sealBox = ComponentFactory.Instance.creatComponentByStylename("CrossGuildTowerDetailFrame.sealBox");
         _bufferBox = ComponentFactory.Instance.creatComponentByStylename("CrossGuildTowerDetailFrame.bufferBox");
         addToContent(_detailBack);
         addToContent(_bloodBar);
         addToContent(_fightText);
         addToContent(_bufferBox);
         addToContent(_troubleText);
         addToContent(_sealBox);
         addToContent(_recordText);
         maxTroubleCount = model.attackConfigAry[3];
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         MsgMan.addObserver("TOWER_DETAIL_BACK",this,__towerDetailBackHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         MsgMan.removeObserver("TOWER_DETAIL_BACK",this,__towerDetailBackHandler);
      }
      
      private function __towerDetailBackHandler(param1:String, param2:Object) : void
      {
         var _loc3_:CrossGuildTowerInfo = param2 as CrossGuildTowerInfo;
         refreshView(_loc3_);
      }
      
      private function refreshView(param1:CrossGuildTowerInfo) : void
      {
         _data = param1;
         if(!_data)
         {
            dispose();
            return;
         }
         _fightText.text = _data.fightPower + "";
         _bloodBar.value = _data.blood / _data.totalBlood;
         _bloodBar.text = LanguageMgr.GetTranslation("CrossGuildTowerAttackFrame.bloodBar.text",_data.blood,_data.totalBlood);
         refreshBufferView();
         refreshSealView();
         refreshRecordText();
      }
      
      public function refreshBufferView() : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:SkillTempInfo = null;
         var _loc4_:Component = null;
         var _loc8_:ScaleFrameImage = null;
         var _loc3_:BaseIconView = null;
         _bufferBox.removeAllChild();
         var _loc1_:int = int(model.getGuildBufferId(_data));
         var _loc2_:Array = [_loc1_,_data.userBufferId];
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc6_ = int(_loc2_[_loc5_]);
            _loc7_ = TempleteManager.instance.skillTemplateDic[_loc6_];
            _loc4_ = new Component();
            _loc8_ = ComponentFactory.Instance.creatComponentByStylename("CrossGuildTowerDetailFrame.profileImage");
            _loc3_ = ComponentFactory.Instance.creatCustomObject("CrossGuildTowerDetailFrame.skillIcon");
            _loc4_.addChild(_loc3_);
            _loc4_.addChild(_loc8_);
            _loc8_.mouseEnabled = false;
            _bufferBox.addChild(_loc4_);
            _loc3_.icon = IconFactory.getTecIconByIcon(_loc7_.Icons);
            _loc3_.tipData = _loc7_;
            _loc8_.visible = _loc7_.Grades > 1;
            _loc8_.setFrame(_loc7_.Grades - 1);
            _loc5_++;
         }
      }
      
      private function refreshSealView() : void
      {
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Image = null;
         var _loc1_:Bitmap = null;
         if(_data.troubleCount % maxTroubleCount == 0)
         {
            _loc5_ = Math.min(_data.troubleCount / maxTroubleCount + 1,6);
         }
         else
         {
            _loc5_ = Math.ceil(_data.troubleCount / maxTroubleCount);
         }
         var _loc4_:int = _loc5_ * maxTroubleCount;
         _troubleText.text = LanguageMgr.GetTranslation("CrossGuildTowerDetailFrame.troubleText.text",maxTroubleCount,_data.troubleCount,_loc4_);
         _sealBox.removeAllChild();
         _loc2_ = 1;
         while(_loc2_ <= 6)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("CrossGuildTowerDetailFrame.followImage" + _loc2_);
            if(_data.sealAry.indexOf(_loc2_) != -1)
            {
               _loc1_ = ComponentFactory.Instance.creatBitmap("asset.CrossGuildTowerDetailFrame.lockImage");
               _loc3_.addChild(_loc1_);
            }
            _sealBox.addChild(_loc3_);
            _loc2_++;
         }
      }
      
      private function refreshRecordText() : void
      {
         var _loc5_:int = 0;
         var _loc7_:CrossGuildRecordInfo = null;
         var _loc6_:int = 0;
         var _loc1_:String = null;
         var _loc2_:String = null;
         _recordText.text = "";
         var _loc4_:String = "";
         var _loc3_:String = "";
         _loc5_ = 1;
         while(_loc5_ <= _data.defendRecordList.length)
         {
            _loc7_ = _data.defendRecordList[_loc5_ - 1];
            _loc1_ = "";
            if(_loc7_.attackType == 3)
            {
               _loc6_ = 3;
            }
            else
            {
               _loc6_ = _loc7_.isWin ? 2 : 1;
               _loc1_ = _loc7_.isWin ? "-" + _loc7_.loseScore : "";
            }
            if(_data.teamId == 0)
            {
               _loc3_ = "<font color=\'#22a908\'>" + _loc7_.nickName + "</font>";
            }
            else
            {
               _loc3_ = "<font color=\'#ffc000\'>" + _loc7_.nickName + "</font>";
            }
            _loc2_ = LanguageMgr.GetTranslation("CrossGuildTowerDetailFrame.RecordText.textType" + _loc6_);
            _loc4_ += _loc5_ + ". " + _loc3_ + "&nbsp;&nbsp;&nbsp;&nbsp;" + _loc2_ + "&nbsp;&nbsp;" + _loc1_ + "\n";
            _loc5_++;
         }
         _recordText.htmlText = _loc4_.substring(0,_loc4_.lastIndexOf("\n"));
      }
      
      private function __frameResponse(param1:FrameEvent) : void
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
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         titleText = LanguageMgr.GetTranslation("CrossGuildTowerAttackFrame.titleText.text");
      }
      
      private function get model() : CrossGuildModel
      {
         return CrossGuildManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_recordText);
         _recordText = null;
         ObjectUtils.disposeObject(_troubleText);
         _troubleText = null;
         ObjectUtils.disposeObject(_fightText);
         _fightText = null;
         ObjectUtils.disposeObject(_detailBack);
         _detailBack = null;
         ObjectUtils.disposeObject(_sealBox);
         _sealBox = null;
         ObjectUtils.disposeObject(_bufferBox);
         _bufferBox = null;
         ObjectUtils.disposeObject(_bloodBar);
         _bloodBar = null;
         super.dispose();
      }
   }
}

