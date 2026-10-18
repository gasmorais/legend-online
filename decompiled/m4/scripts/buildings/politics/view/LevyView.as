package buildings.politics.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.BuildOrderEvent;
   import events.BuildingEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.MagicSpringManager;
   import mvc.module.buildings.BuildInfo;
   import mvc.module.magicspring.MagicSpringSlotInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.BuildingManager;
   import yishi.manager.PlayerManager;
   
   public class LevyView extends Sprite implements Disposeable
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _desTxt:FilterFrameText;
      
      private var _levyTxt:FilterFrameText;
      
      private var _levyValueTxt:FilterFrameText;
      
      private var _levyGoldTxt:FilterFrameText;
      
      private var _levyGoldValueTxt:FilterFrameText;
      
      private var _levyBtn:IconButton;
      
      private var _levyBtnStrip:StripView;
      
      public function LevyView()
      {
         super();
         initView();
         initEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("politics.LevyBack");
         _desTxt = ComponentFactory.Instance.creatComponentByStylename("politics.LevyDescTxt");
         _levyTxt = ComponentFactory.Instance.creatComponentByStylename("politics.LevyTxt");
         _levyValueTxt = ComponentFactory.Instance.creatComponentByStylename("politics.LevyValueTxt");
         _levyGoldTxt = ComponentFactory.Instance.creatComponentByStylename("politics.LevyGoldTxt");
         _levyGoldValueTxt = ComponentFactory.Instance.creatComponentByStylename("politics.LevyGoldValueTxt");
         _levyBtn = ComponentFactory.Instance.creatComponentByStylename("politics.LevyBtn");
         _levyBtnStrip = ComponentFactory.Instance.creatCustomObject("politics.LevyBtnStrip");
         addChild(_back);
         addChild(_desTxt);
         addChild(_levyTxt);
         addChild(_levyValueTxt);
         addChild(_levyGoldTxt);
         addChild(_levyGoldValueTxt);
         addChild(_levyBtn);
         addChild(_levyBtnStrip);
         _desTxt.text = LanguageMgr.GetTranslation("buildings.politics.view.LevyView.des");
         _levyTxt.text = LanguageMgr.GetTranslation("buildings.politics.view.LevyView.levy");
         _levyGoldTxt.text = LanguageMgr.GetTranslation("buildings.politics.view.LevyView.levyGold");
         _levyBtn.enable = false;
         _levyBtnStrip.setTarget(_levyBtn);
         _levyBtnStrip.visible = thane.grades < 14;
         _levyBtnStrip.tipData = LanguageMgr.GetTranslation("store.view.StoreFrame.command01",14);
      }
      
      private function initEvent() : void
      {
         _levyBtn.addEventListener("click",__levyHandler);
         BuildingManager.instance.addEventListener("COLL_ONE_ORDER",__orderChangeHandler);
         BuildingManager.instance.addEventListener("U_C_GOLD_IMPOSERESULT",__changeHandler);
      }
      
      private function removeEvent() : void
      {
         _levyBtn.removeEventListener("click",__levyHandler);
         BuildingManager.instance.removeEventListener("COLL_ONE_ORDER",__orderChangeHandler);
         BuildingManager.instance.removeEventListener("U_C_GOLD_IMPOSERESULT",__changeHandler);
      }
      
      private function __levyHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         PlayerManager.instance.sendLevy();
      }
      
      private function __orderChangeHandler(param1:BuildOrderEvent) : void
      {
         refreshView();
      }
      
      private function __changeHandler(param1:BuildingEvent) : void
      {
         refreshView();
      }
      
      public function refreshView() : void
      {
         var _loc6_:int = 0;
         var _loc5_:BuildInfo = BuildingManager.instance.getBuildingInfoBySonType(901);
         if(_loc5_)
         {
            _levyBtn.enable = _loc5_.property2 - _loc5_.property1 > 0 && thane.grades >= 14;
            _levyValueTxt.text = _loc5_.property2 - _loc5_.property1 + " / " + _loc5_.property2;
         }
         var _loc1_:int = _loc5_.templeteInfo.Property1 * 6;
         var _loc4_:BuildInfo = BuildingManager.instance.getBuildingInfoBySonType(101);
         if(_loc4_)
         {
            _loc1_ += _loc4_.templeteInfo.Property1 * 3;
         }
         var _loc2_:String = _loc1_ + "";
         var _loc3_:MagicSpringSlotInfo = MagicSpringManager.instance.model.checkIsExistBuffer(1);
         if(_loc3_)
         {
            _loc6_ = Math.floor(_loc3_.tempInfo.AddValue * _loc1_ / 100);
            _loc2_ += LanguageMgr.GetTranslation("MagicSpringFrame.buffer.addText",_loc6_);
         }
         if(thane.grades >= 14)
         {
            _levyGoldValueTxt.htmlText = _loc2_;
         }
         else
         {
            _levyGoldValueTxt.text = "0";
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function get levyBtn() : IconButton
      {
         return _levyBtn;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_desTxt);
         _desTxt = null;
         ObjectUtils.disposeObject(_levyTxt);
         _levyTxt = null;
         ObjectUtils.disposeObject(_levyValueTxt);
         _levyValueTxt = null;
         ObjectUtils.disposeObject(_levyGoldTxt);
         _levyGoldTxt = null;
         ObjectUtils.disposeObject(_levyGoldValueTxt);
         _levyGoldValueTxt = null;
         ObjectUtils.disposeObject(_levyBtn);
         _levyBtn = null;
         ObjectUtils.disposeObject(_levyBtnStrip);
         _levyBtnStrip = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

