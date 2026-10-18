package theseus.war.view
{
   import bag.events.BagEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import theseus.war.TheseusWarHufaChooseView;
   import theseus.war.item.TheseusFuHuMetrail;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.WarSoulTempInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.frame.NewVipOpenView;
   import yishi.view.tips.MessageTipManager;
   
   public class TheseusWarFuHuaView extends Sprite
   {
      
      public var _warfh2Bg:Bitmap;
      
      public var _fuhuArrow:MovieClip;
      
      public var _fuhuMatrialItem:TheseusFuHuMetrail;
      
      public var _fuhuEquipIcon:BaseIconView;
      
      public var _warFuhuFxBg:Bitmap;
      
      private var _fuhuBtn2:IconButton;
      
      public var _fuhufNameTxt:FilterFrameText;
      
      private var _fuhuaTimeTxt:FilterFrameText;
      
      private var _idx:int;
      
      private var _vipOpenView:NewVipOpenView;
      
      private var _vipnoCdView:NewVipOpenView;
      
      private var _chooseView:TheseusWarHufaChooseView;
      
      public function TheseusWarFuHuaView()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get fuhuBtn2() : IconButton
      {
         return _fuhuBtn2;
      }
      
      public function get idx() : int
      {
         return _idx;
      }
      
      public function set idx(param1:int) : void
      {
         _idx = param1;
      }
      
      private function initView() : void
      {
         _warfh2Bg = ComponentFactory.Instance.creatBitmap("asset.theseus.warfh2Bg");
         _fuhuArrow = ComponentFactory.Instance.creatCustomObject("ui.theseus.fuhuArrow");
         _fuhuMatrialItem = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.fuhuMatrialItem");
         _fuhuEquipIcon = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.fuhuEquipIcon");
         _warFuhuFxBg = ComponentFactory.Instance.creatBitmap("asset.theseus.warFuhuFxBg");
         _fuhuBtn2 = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.fuhuBtn2");
         _fuhufNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.fuhufNameTxt");
         _fuhuaTimeTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.fuhuaTimeTxt");
         _chooseView = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.choosefuhuaView");
         _vipOpenView = new NewVipOpenView(23);
         _vipOpenView.x = 141;
         _vipOpenView.y = 204;
         _vipOpenView.setWD(250);
         _vipnoCdView = new NewVipOpenView(24);
         _vipnoCdView.x = 141;
         _vipnoCdView.y = 234;
         _vipnoCdView.setWD(250);
         addChild(_warfh2Bg);
         addChild(_fuhuArrow);
         addChild(_fuhuMatrialItem);
         addChild(_fuhuEquipIcon);
         addChild(_warFuhuFxBg);
         addChild(_fuhuBtn2);
         addChild(_fuhufNameTxt);
         addChild(_fuhuaTimeTxt);
         addChild(_vipOpenView);
         addChild(_vipnoCdView);
         addChild(_chooseView);
         _chooseView.visible = false;
         _fuhuMatrialItem.buttonMode = true;
         _fuhuBtn2.enable = false;
      }
      
      private function initEvent() : void
      {
         _fuhuMatrialItem.addEventListener("click",chooseClickHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         _fuhuMatrialItem.removeEventListener("click",chooseClickHandler);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
      }
      
      protected function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc2_:GoodsInfo = GoodsManager.instance.getHideBagItemByPos(0);
         if(_loc2_)
         {
            chooseResultHandler(_loc2_);
         }
      }
      
      private function chooseResultHandler(param1:GoodsInfo) : void
      {
         var _loc2_:int = 0;
         var _loc5_:String = null;
         var _loc3_:GoodsTemplateInfo = param1.templateInfo;
         var _loc6_:Array = TempleteManager.instance.warsoulCate.getListBySontype(_loc3_.Property7);
         var _loc4_:WarSoulTempInfo = _loc6_[0];
         if(_loc4_)
         {
            _fuhufNameTxt.text = _loc4_.Name;
            _fuhuEquipIcon.icon = IconFactory.getTheseusWarSoulIcon(_loc4_.Icon);
            _fuhuBtn2.enable = true;
            _loc2_ = int(_loc3_.Property2);
            if(_vipOpenView)
            {
               _loc2_ -= _vipOpenView.reduce;
               if(_loc2_ < 0)
               {
                  _loc2_ = 0;
               }
            }
            if(_vipnoCdView && _loc3_.Profile <= _vipnoCdView.reduce)
            {
               _loc2_ -= 9999999;
               if(_loc2_ < 0)
               {
                  _loc2_ = 0;
               }
            }
            _loc5_ = DateFormatter.getConsortiaCountDate(_loc2_ * 60);
            _fuhuaTimeTxt.htmlText = LanguageMgr.GetTranslation("theseus.war.fuhuaNeedTime",_loc5_);
            _fuhuMatrialItem.data = param1;
         }
      }
      
      private function chooseClickHandler(param1:MouseEvent) : void
      {
         if(_chooseView.visible)
         {
            return;
         }
         var _loc2_:Array = [760];
         var _loc3_:Array = GoodsManager.instance.getBagCountInPlayerAndStoneBySonType(_loc2_);
         if(_loc3_.length > 0)
         {
            _chooseView.refreshView(_loc3_);
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("theseus.war.chooseNo"));
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
         ObjectUtils.disposeObject(_warfh2Bg);
         _warfh2Bg = null;
         ObjectUtils.disposeViolentMc(_fuhuArrow);
         _fuhuArrow = null;
         ObjectUtils.disposeObject(_fuhuMatrialItem);
         _fuhuMatrialItem = null;
         ObjectUtils.disposeObject(_fuhuEquipIcon);
         _fuhuEquipIcon = null;
         ObjectUtils.disposeObject(_warFuhuFxBg);
         _warFuhuFxBg = null;
         ObjectUtils.disposeObject(_fuhuBtn2);
         _fuhuBtn2 = null;
         ObjectUtils.disposeObject(_fuhufNameTxt);
         _fuhufNameTxt = null;
         ObjectUtils.disposeObject(_fuhuaTimeTxt);
         _fuhuaTimeTxt = null;
         ObjectUtils.disposeObject(_vipOpenView);
         _vipOpenView = null;
         ObjectUtils.disposeObject(_vipnoCdView);
         _vipnoCdView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

