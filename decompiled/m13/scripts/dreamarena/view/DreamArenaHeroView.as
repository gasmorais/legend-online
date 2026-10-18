package dreamarena.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import dreamarena.helper.DreamArenaViewHelper;
   import dreamarena.item.DreamArenaHeroSkillItem;
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
   
   public class DreamArenaHeroView extends Component
   {
      
      private var _headHbox:HBox;
      
      private var _selectBg:Image;
      
      private var _skillItem1:DreamArenaHeroSkillItem;
      
      private var _skillItem2:DreamArenaHeroSkillItem;
      
      private var headList:Vector.<BaseIconView>;
      
      private var _saveBtn:BaseButton;
      
      public function DreamArenaHeroView()
      {
         super();
         initView();
         initListView();
         addEvent();
      }
      
      private function initView() : void
      {
         _skillItem1 = ComponentFactory.Instance.creatCustomObject("DreamArena.DreamArenaHeroView.skillItem1",[1]);
         _skillItem2 = ComponentFactory.Instance.creatCustomObject("DreamArena.DreamArenaHeroView.skillItem2",[2]);
         _headHbox = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaHeroView.headHbox");
         _selectBg = ComponentFactory.Instance.creatComponentByStylename("DreamArenaHeroView.selectBg2");
         _saveBtn = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaHeroView.saveBtn");
         addChild(_headHbox);
         addChild(_selectBg);
         addChild(_skillItem1);
         addChild(_skillItem2);
         addChild(_saveBtn);
         _selectBg.mouseEnabled = false;
      }
      
      private function initListView() : void
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
         var _loc3_:DreamArenaTempInfo = TempleteManager.instance.dreamArenaTempCate.getTempInfoByTypeAndId(1,model.selectJob);
         var _loc2_:int = int(_loc3_.TemplateId);
         var _loc4_:int = int(model.selectJob == selectInfo.selfSelectJob ? selectInfo.skillIndex1 : 0);
         if(model.clientSelectDic[22])
         {
            _loc4_ = int(model.clientSelectDic[22]);
         }
         if(_loc4_ <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("DreamArenaArtifactView.skill.noSelectAlert"));
            return;
         }
         DreamArenaManager.instance.sendHeroSelect(_loc2_,_loc4_);
      }
      
      private function __updateClientSelectHandler(param1:String, param2:Object) : void
      {
         var _loc3_:int = param2 as int;
         if(_loc3_ == 22)
         {
            _skillItem1.refreshClientSelect();
            _skillItem2.refreshClientSelect();
         }
         refreshSaveBtn();
      }
      
      public function refreshView() : void
      {
         _selectBg.x = _headHbox.x + (model.selectJob - 1) * 71 - 10;
         _skillItem1.setJobType(model.selectJob);
         _skillItem2.setJobType(model.selectJob);
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
         _saveBtn.enable = model.getHeroChange();
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
         ObjectUtils.disposeObject(_skillItem2);
         _skillItem2 = null;
         ObjectUtils.disposeObject(_skillItem1);
         _skillItem1 = null;
         ObjectUtils.disposeObject(_saveBtn);
         _saveBtn = null;
         LogicUtils.disposeDisplayCollection(headList,removeHeadEvent);
         super.dispose();
      }
   }
}

