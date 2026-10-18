package dreamarena.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
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
   
   public class DreamArenaRuneView extends Component
   {
      
      private var _back:MutipleImage;
      
      private var _runeCon:TileContainer;
      
      private var _saveBtn:BaseButton;
      
      private var runeList:Vector.<DreamArenaCommonSelectItemII>;
      
      public function DreamArenaRuneView()
      {
         super();
         initView();
         initListView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("DreamArenaRuneView.back");
         _runeCon = ComponentFactory.Instance.creatCustomObject("DreamArenaRuneView.runeCon");
         _saveBtn = ComponentFactory.Instance.creatComponentByStylename("DreamArenaRuneView.saveBtn");
         addChild(_back);
         addChild(_runeCon);
         addChild(_saveBtn);
      }
      
      private function initListView() : void
      {
         var _loc2_:DreamArenaCommonSelectItemII = null;
         var _loc1_:int = 0;
         var _loc3_:Array = TempleteManager.instance.dreamArenaTempCate.getTemplateByType(9);
         runeList = new Vector.<DreamArenaCommonSelectItemII>();
         _loc1_ = 0;
         while(_loc1_ < _loc3_.length)
         {
            _loc2_ = new DreamArenaCommonSelectItemII(4,_loc1_ + 1);
            _loc2_.data = _loc3_[_loc1_];
            _runeCon.appendItem(_loc2_);
            runeList.push(_loc2_);
            _loc1_++;
         }
         refreshSaveBtn();
      }
      
      private function addEvent() : void
      {
         _saveBtn.addEventListener("click",__saveRuneHandler);
         MsgMan.addObserver("DREAM_ARENA_CLIENT_SELECT",this,__updateClientSelectHandler);
      }
      
      private function removeEvent() : void
      {
         if(_saveBtn)
         {
            _saveBtn.removeEventListener("click",__saveRuneHandler);
         }
         MsgMan.removeObserver("DREAM_ARENA_CLIENT_SELECT",this,__updateClientSelectHandler);
      }
      
      private function __saveRuneHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = model.selfInfo.runeId1 + "," + model.selfInfo.runeId2;
         if(model.clientSelectDic[9])
         {
            _loc2_ = (model.clientSelectDic[9] as Array).join(",");
         }
         if(_loc2_.split(",").length < 2)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("DreamArenaArtifactView.runeCount.noEnough"));
            return;
         }
         DreamArenaManager.instance.sendTitanOrRuneSelect(9,_loc2_);
      }
      
      private function __updateClientSelectHandler(param1:String, param2:Object) : void
      {
         var _loc4_:DreamArenaCommonSelectItemII = null;
         var _loc3_:int = 0;
         var _loc5_:int = param2 as int;
         if(_loc5_ == 9)
         {
            _loc3_ = 0;
            while(_loc3_ < runeList.length)
            {
               _loc4_ = runeList[_loc3_];
               _loc4_.refreshClientSelect();
               _loc3_++;
            }
         }
         refreshSaveBtn();
      }
      
      public function refreshView() : void
      {
         var _loc2_:DreamArenaCommonSelectItemII = null;
         var _loc1_:int = 0;
         var _loc3_:Array = TempleteManager.instance.dreamArenaTempCate.getTemplateByType(9);
         _loc1_ = 0;
         while(_loc1_ < runeList.length)
         {
            _loc2_ = runeList[_loc1_];
            _loc2_.data = _loc3_[_loc1_];
            _loc1_++;
         }
         refreshSaveBtn();
      }
      
      private function refreshSaveBtn() : void
      {
         _saveBtn.enable = model.getRuneChange();
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
         ObjectUtils.disposeObject(_runeCon);
         _runeCon = null;
         ObjectUtils.disposeObject(_saveBtn);
         _saveBtn = null;
         LogicUtils.disposeDisplayCollection(runeList);
         runeList = null;
         model.clientSelectDic.del(9);
         super.dispose();
      }
   }
}

