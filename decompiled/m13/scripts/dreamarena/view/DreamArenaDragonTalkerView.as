package dreamarena.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import dreamarena.helper.DreamArenaViewHelper;
   import dreamarena.item.DreamAreaDragonSkillBar;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DreamArenaManager;
   import mvc.module.dreamarena.DreamArenaModel;
   import mvc.module.dreamarena.DreamArenaSelectRoleInfo;
   import utils.LogicUtils;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.DreamArenaTempInfo;
   import yishi.datas.templates.GameHeroTempInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class DreamArenaDragonTalkerView extends Component
   {
      
      private var _headHbox:HBox;
      
      private var _selectBg:Image;
      
      private var headList:Vector.<BaseIconView>;
      
      private var _saveBtn:BaseButton;
      
      private var _talismanView:DreamArenaTalismanView;
      
      private var _proficiencyView:DreamArenaProficiencyView;
      
      private var _skillBar1:DreamAreaDragonSkillBar;
      
      private var _skillBar2:DreamAreaDragonSkillBar;
      
      private var _skillImage:ScaleBitmapImage;
      
      private var _chooseTitleTxt:FilterFrameText;
      
      public function DreamArenaDragonTalkerView()
      {
         super();
         initView();
         initHeadView();
         addEvent();
      }
      
      private function initView() : void
      {
         _talismanView = ComponentFactory.Instance.creatCustomObject("DreamArena.DreamArenaDragonTalkerView.talismanView");
         _proficiencyView = ComponentFactory.Instance.creatCustomObject("DreamArena.DreamArenaDragonTalkerView.proficiencyView");
         _skillBar1 = ComponentFactory.Instance.creatComponentByStylename("dreamarena.item.DreamAreaDragonSkillBar1",[1]);
         _skillBar2 = ComponentFactory.Instance.creatComponentByStylename("dreamarena.item.DreamAreaDragonSkillBar2",[2]);
         _headHbox = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaDragonTalkerView.headHbox");
         _selectBg = ComponentFactory.Instance.creatComponentByStylename("DreamArenaDragonTalkerView.selectBg2");
         _saveBtn = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaHeroView.saveBtn");
         _skillImage = ComponentFactory.Instance.creatComponentByStylename("DreamArena.dragonskillScaleImg");
         _chooseTitleTxt = ComponentFactory.Instance.creatComponentByStylename("ui.dreamarea.chooseSkTitle");
         addChild(_headHbox);
         addChild(_selectBg);
         addChild(_talismanView);
         addChild(_proficiencyView);
         addChild(_skillImage);
         addChild(_skillBar1);
         addChild(_skillBar2);
         addChild(_saveBtn);
         addChild(_chooseTitleTxt);
         _chooseTitleTxt.text = LanguageMgr.GetTranslation("dreamarea.skill.chooseTip");
         _selectBg.mouseEnabled = false;
      }
      
      private function initHeadView() : void
      {
         var _loc1_:BaseIconView = null;
         var _loc3_:Bitmap = null;
         var _loc4_:Component = null;
         var _loc6_:GameHeroTempInfo = null;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         headList = new Vector.<BaseIconView>();
         _loc5_ = 1;
         while(_loc5_ <= 4)
         {
            _loc4_ = new Component();
            _loc3_ = ComponentFactory.Instance.creatBitmap("asset.DreamArenaHeroView.heroBack");
            _loc1_ = ComponentFactory.Instance.creatCustomObject("DreamArena.DreamArenaHeroView.headIcon");
            _loc1_.addEventListener("click",__headSelectHandler);
            _loc2_ = int(playerInfo.sexs == 0 ? _loc5_ + 3 : _loc5_);
            _loc6_ = TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(_loc2_);
            if(_loc5_ == 4)
            {
               _loc1_.icon = IconFactory.getHeroIconByPics(DreamArenaViewHelper.getDragonTalkerIcon());
            }
            else
            {
               _loc1_.icon = IconFactory.getHeroIconByPics(_loc6_.Icon);
            }
            _loc4_.addChild(_loc3_);
            _loc4_.addChild(_loc1_);
            _headHbox.addChild(_loc4_);
            headList.push(_loc1_);
            _loc1_.tipData = LanguageMgr.GetTranslation("yishi.datas.consant.JobType.JobName" + _loc5_);
            _loc5_++;
         }
      }
      
      private function addEvent() : void
      {
         _saveBtn.addEventListener("click",__saveHeroHandler);
         MsgMan.addObserver("DREAM_ARENA_CLIENT_SELECT",this,__updateClientSelectHandler);
      }
      
      private function removeEvent() : void
      {
         if(_saveBtn)
         {
            _saveBtn.removeEventListener("click",__saveHeroHandler);
         }
         MsgMan.removeObserver("DREAM_ARENA_CLIENT_SELECT",this,__updateClientSelectHandler);
      }
      
      private function __saveHeroHandler(param1:MouseEvent) : void
      {
         var _loc4_:DreamArenaTempInfo = TempleteManager.instance.dreamArenaTempCate.getTempInfoByTypeAndId(1,0);
         var _loc2_:int = int(_loc4_.TemplateId);
         var _loc8_:int = int(selectInfo.selfSelectJob == 4 ? selectInfo.skillIndex1 : 0);
         var _loc9_:int = int(selectInfo.selfSelectJob == 4 ? selectInfo.skillIndex2 : 0);
         var _loc6_:String = selectInfo.selfSelectJob == 4 ? selectInfo.talismanSkillsAry.join(",") : "";
         if(model.clientSelectDic[23])
         {
            _loc9_ = int(model.clientSelectDic[23]);
         }
         if(model.clientSelectDic[24])
         {
            _loc6_ = model.clientSelectDic[24];
         }
         if(_loc9_ <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("DreamArenaArtifactView.profiency.noSelectAlert"));
            return;
         }
         if(_loc6_.split(",").length < 4)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("DreamArenaArtifactView.talismanCount.noEnough"));
            return;
         }
         var _loc3_:String = _skillBar1.selectIds;
         var _loc7_:String = _skillBar2.selectIds;
         var _loc5_:String = _loc3_ + "|" + _loc7_;
         DreamArenaManager.instance.sendDragonTalkerSelect(_loc2_,_loc8_,_loc9_,_loc6_,_loc5_);
      }
      
      private function __updateClientSelectHandler(param1:String, param2:Object) : void
      {
         var _loc3_:int = param2 as int;
         if(_loc3_ == 22)
         {
            _skillBar1.refreshClientSelect();
            _skillBar2.refreshClientSelect();
         }
         else if(_loc3_ == 23)
         {
            if(_proficiencyView)
            {
               _proficiencyView.refreshClientSelect();
            }
         }
         else if(_loc3_ == 24)
         {
            if(_talismanView)
            {
               _talismanView.refreshClientSelect();
            }
         }
         refreshSaveBtn();
      }
      
      public function refreshView() : void
      {
         _selectBg.x = _headHbox.x + (model.selectJob - 1) * 71 - 10;
         _skillBar1.setJobType(model.selectJob);
         _skillBar2.setJobType(model.selectJob);
         if(_proficiencyView)
         {
            _proficiencyView.refreshView();
         }
         if(_talismanView)
         {
            _talismanView.refreshView();
         }
         refreshSaveBtn();
      }
      
      private function __headSelectHandler(param1:MouseEvent) : void
      {
         var _loc2_:BaseIconView = param1.currentTarget as BaseIconView;
         var _loc3_:int = headList.indexOf(_loc2_);
         if(_loc3_ == -1)
         {
            return;
         }
         model.selectJob = _loc3_ + 1;
      }
      
      private function refreshSaveBtn() : void
      {
         var _loc1_:Boolean = Boolean(model.getHeroChange());
         _saveBtn.enable = _loc1_;
      }
      
      private function get selectInfo() : DreamArenaSelectRoleInfo
      {
         return model.selfInfo;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get model() : DreamArenaModel
      {
         return DreamArenaManager.instance.model;
      }
      
      private function removeHeadEvent(param1:DisplayObject) : void
      {
         param1.removeEventListener("click",__headSelectHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_selectBg);
         _selectBg = null;
         ObjectUtils.disposeObject(_headHbox);
         _headHbox = null;
         ObjectUtils.disposeObject(_talismanView);
         _talismanView = null;
         ObjectUtils.disposeObject(_proficiencyView);
         _proficiencyView = null;
         ObjectUtils.disposeObject(_skillBar1);
         _skillBar1 = null;
         ObjectUtils.disposeObject(_skillBar2);
         _skillBar2 = null;
         ObjectUtils.disposeObject(_saveBtn);
         _saveBtn = null;
         ObjectUtils.disposeObject(_chooseTitleTxt);
         _chooseTitleTxt = null;
         LogicUtils.disposeDisplayCollection(headList,removeHeadEvent);
         super.dispose();
      }
   }
}

