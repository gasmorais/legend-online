package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.BattleGuardSocketInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class BattleGuardItemTip extends BaseTip
   {
      
      private var _nameTxt:FilterFrameText;
      
      private var _contentTxt:FilterFrameText;
      
      private var _line:ScaleBitmapImage;
      
      private var _vBox:VBox;
      
      private var _oneLineTxt:FilterFrameText;
      
      public function BattleGuardItemTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         var _loc2_:int = 0;
         var _loc1_:SocketItemView = null;
         super.init();
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("BattleGuardItemTip.nameTxt");
         _line = ComponentFactory.Instance.creatComponentByStylename("BattleGuardItemTip.Line");
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("BattleGuardItemTip.contentTxt");
         addChild(_nameTxt);
         addChild(_line);
         addChild(_contentTxt);
         _bg.width = 230;
         _bg.height = 70;
         _vBox = ComponentFactory.Instance.creatComponentByStylename("BattleGuardItemTip.vbox01");
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new SocketItemView();
            _vBox.addChild(_loc1_);
            _loc2_++;
         }
         _oneLineTxt = ComponentFactory.Instance.creatComponentByStylename("core.commonTipText");
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:int = 0;
         if(!(tipData is BattleGuardSocketInfo))
         {
            return;
         }
         var _loc3_:BattleGuardSocketInfo = tipData as BattleGuardSocketInfo;
         var _loc2_:Array = LanguageMgr.GetTranslation("BattleGuardItemNames").split(",");
         if(_loc3_.type == 1)
         {
            _loc1_ = _loc3_.pos + 7;
            _nameTxt.text = _loc2_[0];
         }
         else
         {
            _loc1_ = _loc3_.pos + 1;
            _nameTxt.text = _loc2_[_loc1_];
         }
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
         addChild(_bg);
         if(_loc3_.state == 1)
         {
            addChild(_nameTxt);
            addChild(_line);
            addChild(_vBox);
            openStateTip(_loc3_);
         }
         else
         {
            addChild(_nameTxt);
            addChild(_line);
            addChild(_contentTxt);
            lockStateTip(_loc1_);
         }
      }
      
      override public function get height() : Number
      {
         if(_bg)
         {
            return _bg.height;
         }
         return super.height;
      }
      
      override public function get width() : Number
      {
         if(_bg)
         {
            return _bg.width;
         }
         return super.width;
      }
      
      private function openStateTip(param1:BattleGuardSocketInfo) : void
      {
         var _loc4_:int = 0;
         var _loc2_:SocketItemView = null;
         var _loc3_:GoodsTemplateInfo = null;
         _loc4_ = 0;
         while(_loc4_ < _vBox.numChildren)
         {
            _loc2_ = _vBox.getChildAt(_loc4_) as SocketItemView;
            _loc3_ = param1.getTempByPos(_loc4_);
            _loc2_.setData(_loc3_);
            _loc4_++;
         }
         _bg.width = 230;
         _bg.height = _vBox.y + _vBox.height + 10;
      }
      
      private function lockStateTip(param1:int) : void
      {
         var _loc4_:UpgradeTemplateInfo = null;
         var _loc5_:String = null;
         var _loc2_:Array = TempleteManager.instance.getTemplatesByType(28);
         for each(var _loc3_:UpgradeTemplateInfo in _loc2_)
         {
            if(_loc3_.ActiveObject == param1)
            {
               _loc4_ = _loc3_;
               break;
            }
         }
         if(_loc4_)
         {
            _loc5_ = "";
            if(param1 < 7)
            {
               _loc5_ = LanguageMgr.GetTranslation("armyII.viewII.equip.EquipView.runes",_loc4_.Grades);
               if(_loc4_.Data > 0)
               {
                  _loc5_ += "<br/>" + LanguageMgr.GetTranslation("BattleGuardItemTip.pointTip",_loc4_.Data);
               }
            }
            else
            {
               _loc5_ = LanguageMgr.GetTranslation("armyII.viewII.equip.EquipView.runes",_loc4_.Grades);
            }
            _contentTxt.htmlText = _loc5_;
            _contentTxt.height = _contentTxt.textHeight + 5;
         }
         _bg.width = Math.max(_contentTxt.textWidth + 23,210);
         _bg.height = _contentTxt.y + _contentTxt.textHeight + 10;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_contentTxt);
         _contentTxt = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         super.dispose();
      }
   }
}

import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.text.FilterFrameText;
import com.pickgliss.utils.ObjectUtils;
import flash.display.Sprite;
import manager.LanguageMgr;
import yishi.datas.templates.GoodsTemplateInfo;
import yishi.view.community.BaseIconView;

class SocketItemView extends Sprite
{
   
   private var _icon:BaseIconView;
   
   private var _txt:FilterFrameText;
   
   public function SocketItemView()
   {
      super();
      _icon = ComponentFactory.Instance.creatCustomObject("SocketItemView.icon");
      _txt = ComponentFactory.Instance.creatComponentByStylename("SocketItemView.txt");
      addChild(_icon);
      addChild(_txt);
   }
   
   public function setData(param1:GoodsTemplateInfo) : void
   {
      var _loc2_:int = 0;
      var _loc3_:String = null;
      if(param1)
      {
         _loc2_ = int(param1.Property2);
         _loc3_ = LanguageMgr.GetTranslation("public.level4_space2",_loc2_);
         if(_loc2_ > 9)
         {
            _loc3_ += " " + param1.Description;
         }
         else
         {
            _loc3_ += "  " + param1.Description;
         }
         _txt.htmlText = _loc3_;
         _icon.icon = param1.iconPath;
      }
      else
      {
         _txt.htmlText = LanguageMgr.GetTranslation("yishi.view.tips.goods.InlayItem.value02");
         _icon.icon = ComponentFactory.Instance.creatBitmap("asset.tips.equipUnmount");
      }
   }
   
   public function dispose() : void
   {
      ObjectUtils.disposeObject(_icon);
      _icon = null;
      ObjectUtils.disposeObject(_txt);
      _txt = null;
   }
}
