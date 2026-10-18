package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.SpiritExpeditionTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   
   public class SpiritExpeditionNodeTips extends BaseTip
   {
      
      private var _purpleBg:Scale9CornerImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _index:FilterFrameText;
      
      private var _headIcon:BaseIconView;
      
      private var _profileImg:ScaleFrameImage;
      
      private var _vBox:VBox;
      
      private var _line01:Bitmap;
      
      private var _dropTxt:FilterFrameText;
      
      private var _dropHox:HBox;
      
      public function SpiritExpeditionNodeTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _purpleBg = ComponentFactory.Instance.creatComponentByStylename("core.purpleItemTipsBg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("petTip.nameTxt");
         _index = ComponentFactory.Instance.creatComponentByStylename("RemotePetTurnTip.indexTxt");
         _headIcon = ComponentFactory.Instance.creatCustomObject("petTip.headIcon");
         _profileImg = ComponentFactory.Instance.creatComponentByStylename("tips.profileImg");
         _line01 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("RemotePetTurnTip.vBox");
         _dropTxt = ComponentFactory.Instance.creatComponentByStylename("RemotePetTurnTip.dropTxt");
         _dropHox = ComponentFactory.Instance.creatComponentByStylename("RemotePetTurnTip.dropHox");
         _profileImg.x = 10;
         _profileImg.y = 10;
         _line01.width = 280;
         addChild(_purpleBg);
         addChild(_nameTxt);
         _nameTxt.multiline = true;
         _nameTxt.wordWrap = true;
         _nameTxt.height = 40;
         addChild(_index);
         addChild(_headIcon);
         addChild(_profileImg);
         _profileImg.setFrame(4);
         addChild(_line01);
         _line01.y = 85;
         addChild(_vBox);
         _dropTxt.text = LanguageMgr.GetTranslation("SpiritExpeditionNodeTips.dropTxt.text");
         _bg.width = 284;
         _purpleBg.width = _bg.width;
         _bg.visible = false;
      }
      
      override protected function updateTransform() : void
      {
         var _loc2_:SpiritExpeditionTempInfo = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc1_:BaseItemView = null;
         var _loc5_:GoodsInfo = null;
         clean();
         if(_data is SpiritExpeditionTempInfo)
         {
            if(_dropHox)
            {
               _dropHox.removeAllChild();
            }
            _loc2_ = _data as SpiritExpeditionTempInfo;
            if(_loc2_.bossTemp)
            {
               _nameTxt.text = _loc2_.bossTemp.TemplateName;
               _headIcon.icon = IconFactory.getHeroicon(_loc2_.bossTemp.TemplateId);
            }
            else if(_loc2_.npcTemp)
            {
               _nameTxt.text = _loc2_.npcTemp.Name;
               _headIcon.icon = IconFactory.getSoldierIconByIcon(_loc2_.npcTemp.Icon);
            }
            _nameTxt.setFrame(4);
            _index.text = _loc2_.AreaId + "-" + _loc2_.NodeId;
            _vBox.addChild(_dropTxt);
            _loc3_ = TempleteManager.instance.spiritExpeditionFightDropTempCate.getTemplatesByAreaAndNode(_loc2_.AreaId,_loc2_.NodeId);
            if(_loc3_)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc3_.length)
               {
                  _loc1_ = ComponentFactory.Instance.creatCustomObject("RemotePetTurnTip.dropItem");
                  _loc5_ = new GoodsInfo();
                  _loc5_.templateId = _loc3_[_loc4_].itemId;
                  _loc5_.count = _loc3_[_loc4_].count;
                  _loc1_.data = _loc5_;
                  _dropHox.addChild(_loc1_);
                  _loc4_++;
               }
            }
            _vBox.addChild(_dropHox);
         }
         _bg.height = _vBox.y + _vBox.height + 10;
         _purpleBg.height = _bg.height - 10;
      }
      
      private function clean() : void
      {
         _index.text = "";
         _nameTxt.text = "";
         _vBox.removeAllChild();
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

