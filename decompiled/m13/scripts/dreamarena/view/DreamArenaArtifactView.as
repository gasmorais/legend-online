package dreamarena.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import dreamarena.item.DreamArenaCommonSelectItem;
   import dreamarena.item.DreamArenaCommonSelectItemII;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DreamArenaManager;
   import mvc.module.dreamarena.DreamArenaModel;
   import utils.LogicUtils;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.component.TileContainer;
   import yishi.view.tips.MessageTipManager;
   
   public class DreamArenaArtifactView extends Component
   {
      
      private var _back:MutipleImage;
      
      private var _artifactCon:TileContainer;
      
      private var _armoryHbox:HBox;
      
      private var _saveBtn:BaseButton;
      
      private var artifactList:Vector.<DreamArenaCommonSelectItemII>;
      
      private var armoryList:Vector.<DreamArenaCommonSelectItem>;
      
      public function DreamArenaArtifactView()
      {
         super();
         initView();
         initListView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("DreamArenaArtifactView.back");
         _artifactCon = ComponentFactory.Instance.creatCustomObject("DreamArenaArtifactView.artifactCon");
         _armoryHbox = ComponentFactory.Instance.creatComponentByStylename("DreamArenaArtifactView.armoryHbox");
         _saveBtn = ComponentFactory.Instance.creatComponentByStylename("DreamArenaArtifactView.saveBtn");
         addChild(_back);
         addChild(_artifactCon);
         addChild(_armoryHbox);
         addChild(_saveBtn);
      }
      
      private function initListView() : void
      {
         var _loc5_:DreamArenaCommonSelectItemII = null;
         var _loc3_:DreamArenaCommonSelectItem = null;
         var _loc4_:int = 0;
         var _loc1_:Array = TempleteManager.instance.dreamArenaTempCate.getTemplateByType(6);
         var _loc2_:Array = TempleteManager.instance.dreamArenaTempCate.getTemplateByType(7);
         artifactList = new Vector.<DreamArenaCommonSelectItemII>();
         armoryList = new Vector.<DreamArenaCommonSelectItem>();
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc5_ = new DreamArenaCommonSelectItemII(1,_loc4_ + 1);
            _loc5_.data = _loc1_[_loc4_];
            _artifactCon.appendItem(_loc5_);
            artifactList.push(_loc5_);
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = new DreamArenaCommonSelectItem(1,_loc4_ + 1);
            _loc3_.data = _loc2_[_loc4_];
            _armoryHbox.addChild(_loc3_);
            armoryList.push(_loc3_);
            _loc4_++;
         }
         refreshSaveBtn();
      }
      
      private function addEvent() : void
      {
         _saveBtn.addEventListener("click",__saveArtifactHandler);
         MsgMan.addObserver("DREAM_ARENA_CLIENT_SELECT",this,__updateClientSelectHandler);
      }
      
      private function removeEvent() : void
      {
         if(_saveBtn)
         {
            _saveBtn.removeEventListener("click",__saveArtifactHandler);
         }
         MsgMan.removeObserver("DREAM_ARENA_CLIENT_SELECT",this,__updateClientSelectHandler);
      }
      
      private function __saveArtifactHandler(param1:MouseEvent) : void
      {
         var _loc3_:int = int(model.selfInfo.artifactId);
         var _loc2_:String = model.selfInfo.armoryId1 + "," + model.selfInfo.armoryId2 + "," + model.selfInfo.armoryId3;
         if(model.clientSelectDic[6])
         {
            _loc3_ = int(model.clientSelectDic[6]);
         }
         if(model.clientSelectDic[7])
         {
            _loc2_ = (model.clientSelectDic[7] as Array).join(",");
         }
         if(_loc2_.split(",").length < 3)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("DreamArenaArtifactView.armoryCount.noEnough"));
            return;
         }
         DreamArenaManager.instance.sendArtifactSelect(_loc3_,_loc2_);
      }
      
      private function __updateClientSelectHandler(param1:String, param2:Object) : void
      {
         var _loc6_:DreamArenaCommonSelectItemII = null;
         var _loc4_:int = 0;
         var _loc3_:DreamArenaCommonSelectItem = null;
         var _loc5_:int = param2 as int;
         if(_loc5_ == 6)
         {
            _loc4_ = 0;
            while(_loc4_ < artifactList.length)
            {
               _loc6_ = artifactList[_loc4_];
               _loc6_.refreshClientSelect();
               _loc4_++;
            }
         }
         else if(_loc5_ == 7)
         {
            _loc4_ = 0;
            while(_loc4_ < armoryList.length)
            {
               _loc3_ = armoryList[_loc4_];
               _loc3_.refreshClientSelect();
               _loc4_++;
            }
         }
         refreshSaveBtn();
      }
      
      public function refreshView() : void
      {
         var _loc5_:DreamArenaCommonSelectItemII = null;
         var _loc3_:DreamArenaCommonSelectItem = null;
         var _loc4_:int = 0;
         var _loc1_:Array = TempleteManager.instance.dreamArenaTempCate.getTemplateByType(6);
         var _loc2_:Array = TempleteManager.instance.dreamArenaTempCate.getTemplateByType(7);
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc5_ = artifactList[_loc4_];
            _loc5_.data = _loc1_[_loc4_];
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = armoryList[_loc4_];
            _loc3_.data = _loc2_[_loc4_];
            _loc4_++;
         }
         refreshSaveBtn();
      }
      
      private function refreshSaveBtn() : void
      {
         _saveBtn.enable = model.getArtifactChange();
      }
      
      private function get model() : DreamArenaModel
      {
         return DreamArenaManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_artifactCon);
         _artifactCon = null;
         ObjectUtils.disposeObject(_armoryHbox);
         _armoryHbox = null;
         ObjectUtils.disposeObject(_saveBtn);
         _saveBtn = null;
         LogicUtils.disposeDisplayCollection(armoryList);
         armoryList = null;
         LogicUtils.disposeDisplayCollection(artifactList);
         artifactList = null;
         model.clientSelectDic.del(6);
         model.clientSelectDic.del(7);
         super.dispose();
      }
   }
}

