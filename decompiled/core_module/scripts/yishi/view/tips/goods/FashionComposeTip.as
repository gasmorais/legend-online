package yishi.view.tips.goods
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.BaseTip;
   
   public class FashionComposeTip extends BaseTip
   {
      
      private var _purpleBg:Scale9CornerImage;
      
      private var _totalBox:VBox;
      
      private var _con:Sprite;
      
      private var _title1:FilterFrameText;
      
      private var _title1Bg:Image;
      
      private var _line1:Bitmap;
      
      private var _vBox1:VBox;
      
      private var _refreshItem1:EquipRefreshTipItem;
      
      private var _refreshItem2:EquipRefreshTipItem;
      
      private var _con2:Sprite;
      
      private var _title2:FilterFrameText;
      
      private var _title2Bg:Image;
      
      private var _line2:Bitmap;
      
      private var _vBox2:VBox;
      
      private var _refreshItem3:EquipRefreshTipItem;
      
      private var _refreshItem4:EquipRefreshTipItem;
      
      public function FashionComposeTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 320;
         _purpleBg = ComponentFactory.Instance.creatComponentByStylename("core.purpleItemTipsBg");
         _totalBox = ComponentFactory.Instance.creatComponentByStylename("tips.SkillTotalBox");
         _con = new Sprite();
         _title1Bg = ComponentFactory.Instance.creatComponentByStylename("tips.skilltiptile.bg");
         _title1 = ComponentFactory.Instance.creatComponentByStylename("tips.skilltitle.titleTxt");
         _line1 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _vBox1 = ComponentFactory.Instance.creatComponentByStylename("tips.SkillSubBox");
         _con2 = new Sprite();
         _title2Bg = ComponentFactory.Instance.creatComponentByStylename("tips.skilltiptile.bg");
         _title2 = ComponentFactory.Instance.creatComponentByStylename("tips.skilltitle.titleTxt");
         _line2 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _vBox2 = ComponentFactory.Instance.creatComponentByStylename("tips.SkillSubBox");
         _refreshItem1 = new EquipRefreshTipItem();
         _refreshItem2 = new EquipRefreshTipItem();
         _refreshItem3 = new EquipRefreshTipItem();
         _refreshItem4 = new EquipRefreshTipItem();
         addChild(_purpleBg);
         addChild(_totalBox);
         _con.addChild(_title1Bg);
         _con.addChild(_title1);
         _con2.addChild(_title2Bg);
         _con2.addChild(_title2);
         _purpleBg.width = 320;
         _bg.visible = false;
         _title1Bg.visible = false;
         _purpleBg.height = _totalBox.x + _totalBox.height + 6;
      }
      
      override protected function updateTransform() : void
      {
         var _loc6_:SkillTempInfo = null;
         var _loc5_:int = 0;
         clean();
         var _loc3_:int = tipData as int;
         _title1.text = LanguageMgr.GetTranslation("fashioncomposetip.current");
         var _loc7_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(_loc3_,113);
         var _loc4_:String = _loc7_.TemplateName;
         var _loc2_:Array = TempleteManager.instance.getSkillTemplateInfoByIds(_loc4_);
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc6_ = _loc2_[_loc5_] as SkillTempInfo;
            if(_loc6_)
            {
               if(_loc5_ == 1)
               {
                  this["_refreshItem" + (_loc5_ + 1)].isShowAdd(true);
               }
               this["_refreshItem" + (_loc5_ + 1)].setData(_loc6_.TemplateName);
               _vBox1.addChild(this["_refreshItem" + (_loc5_ + 1)]);
            }
            _loc5_++;
         }
         _totalBox.addChild(_con);
         _totalBox.addChild(_line1);
         _totalBox.addChild(_vBox1);
         var _loc1_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(_loc3_ + 1,113);
         if(_loc1_)
         {
            _title2.text = LanguageMgr.GetTranslation("fashioncomposetip.next");
            _loc4_ = _loc1_.TemplateName;
            _loc2_ = TempleteManager.instance.getSkillTemplateInfoByIds(_loc4_);
            _loc5_ = 0;
            while(_loc5_ < _loc2_.length)
            {
               _loc6_ = _loc2_[_loc5_] as SkillTempInfo;
               if(_loc6_)
               {
                  if(_loc5_ == 1)
                  {
                     this["_refreshItem" + (_loc5_ + 3)].isShowAdd(true);
                  }
                  this["_refreshItem" + (_loc5_ + 3)].setData(_loc6_.TemplateName);
                  _vBox2.addChild(this["_refreshItem" + (_loc5_ + 3)]);
               }
               _loc5_++;
            }
            _totalBox.addChild(_con2);
            _totalBox.addChild(_line2);
            _totalBox.addChild(_vBox2);
         }
         else
         {
            _title1.text = LanguageMgr.GetTranslation("fashioncomposetip.maxGrade");
            _title1.setFrame(2);
         }
         _purpleBg.height = _totalBox.x + _totalBox.height + 6;
      }
      
      private function clean() : void
      {
         _title1.text = "";
         _title2.text = "";
         _vBox1.removeAllChild();
         _vBox2.removeAllChild();
         _totalBox.removeAllChild();
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

