package chess
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.templates.SelfChessTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.BaseTip;
   
   public class SelfChessTipView extends BaseTip
   {
      
      public var _box50:Bitmap;
      
      public var _tipIcon1:BaseIconView;
      
      public var _tipIcon2:BaseIconView;
      
      public var _tipGold:Image;
      
      public var _tipDesTxt:FilterFrameText;
      
      public var _tipHeroNameTxt:FilterFrameText;
      
      public var _tipSkillIcon:BaseIconView;
      
      public var _tipHeroGoldTxt:FilterFrameText;
      
      private var _attBox1:VBox;
      
      private var _attBox2:VBox;
      
      private var _txtList:Array = [];
      
      private var _skSp:Sprite;
      
      private var _skLine:Bitmap;
      
      private var _Line:Bitmap;
      
      private var _btHeroIcon:BaseIconView;
      
      private var _profileBit:ScaleFrameImage;
      
      public function SelfChessTipView()
      {
         super();
         initView();
      }
      
      override protected function updateTransform() : void
      {
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         var _loc7_:Array = null;
         var _loc11_:int = 0;
         var _loc9_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:FilterFrameText = null;
         var _loc12_:String = null;
         var _loc6_:int = 0;
         var _loc10_:Array = null;
         var _loc13_:SkillTempInfo = null;
         var _loc14_:SelfChessTempInfo = tipData as SelfChessTempInfo;
         if(_loc14_)
         {
            _loc3_ = _loc14_.Grade + (_loc14_.Star - 1) * 2;
            visible = true;
            _btHeroIcon.icon = PathManager.solveCampaignMovieByUrl(_loc14_.Icon);
            _tipHeroNameTxt.text = "" + _data.TemplateName;
            _tipHeroGoldTxt.text = "" + _loc3_;
            _profileBit.setFrame(_loc14_.Grade);
            _loc4_ = _loc14_.Job.split(",");
            _loc5_ = int(_loc4_[0]);
            if(_loc5_ > 0)
            {
               _tipIcon1.icon = PathManager.getSelfChessKindIcon(false,_loc5_);
            }
            else
            {
               _tipIcon1.icon = null;
            }
            _loc8_ = int(_loc4_[1]);
            if(_loc8_ > 0)
            {
               _tipIcon2.icon = PathManager.getSelfChessKindIcon(false,_loc8_);
            }
            else
            {
               _tipIcon2.icon = null;
            }
            _loc7_ = ["Attack","Defence","MagicAttack","MagicDefence","Live","Parry","ForceHit"];
            _loc11_ = int(_loc7_.length);
            _attBox1.removeAllChild();
            _attBox2.removeAllChild();
            _attBox1.beginChanges();
            _attBox2.beginChanges();
            _loc6_ = 0;
            while(_loc6_ < _loc11_)
            {
               _loc12_ = _loc7_[_loc6_];
               _loc9_ = int(_loc14_[_loc12_]);
               if(_loc9_ > 0)
               {
                  _loc2_ = _txtList[_loc1_];
                  _loc2_.htmlText = LanguageMgr.GetTranslation("selfchess.attName_" + _loc12_,_loc9_);
                  if(++_loc1_ % 2 == 0)
                  {
                     _attBox2.addChild(_loc2_);
                  }
                  else
                  {
                     _attBox1.addChild(_loc2_);
                  }
               }
               _loc6_++;
            }
            _attBox1.commitChanges();
            _attBox2.commitChanges();
            if(_attBox1.displayHeight > _attBox2.displayHeight)
            {
               _skSp.y = _attBox1.y + _attBox1.displayHeight;
            }
            else
            {
               _skSp.y = _attBox2.y + _attBox2.displayHeight;
            }
            _loc10_ = _loc14_.SkillScript.split(",");
            _loc13_ = TempleteManager.instance.getSkillTemplateInfoById(int(_loc10_[0]));
            _tipDesTxt.text = _loc13_.Description;
            _tipSkillIcon.icon = IconFactory.getTecIconByIcon(_loc13_.Icons);
            _bg.height = _skSp.y + _skSp.height + 10;
         }
         else
         {
            visible = false;
         }
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         _box50 = ComponentFactory.Instance.creatBitmap("asset.selfchess.box50");
         _btHeroIcon = ComponentFactory.Instance.creatCustomObject("ui.selfchess.tipHeroIcon");
         _tipIcon1 = ComponentFactory.Instance.creatCustomObject("ui.selfchess.tipIcon1");
         _tipIcon2 = ComponentFactory.Instance.creatCustomObject("ui.selfchess.tipIcon2");
         _tipGold = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.tipGold");
         _tipDesTxt = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.tipDesTxt");
         _tipHeroNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.tipHeroNameTxt");
         _tipSkillIcon = ComponentFactory.Instance.creatCustomObject("ui.selfchess.tipSkillIcon");
         _tipHeroGoldTxt = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.tipHeroGoldTxt");
         _attBox1 = ComponentFactory.Instance.creatCustomObject("ui.selfchess.tipAttBox1");
         _attBox2 = ComponentFactory.Instance.creatCustomObject("ui.selfchess.tipAttBox2");
         _skLine = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _Line = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _profileBit = ComponentFactory.Instance.creatComponentByStylename("selfchess.TipiconProfile");
         _skSp = new Sprite();
         addChild(_box50);
         addChild(_tipIcon1);
         addChild(_tipIcon2);
         addChild(_btHeroIcon);
         addChild(_profileBit);
         addChild(_tipGold);
         addChild(_tipHeroNameTxt);
         addChild(_tipHeroGoldTxt);
         addChild(_attBox1);
         addChild(_attBox2);
         addChild(_skSp);
         addChild(_Line);
         _skSp.addChild(_skLine);
         _skSp.addChild(_tipSkillIcon);
         _skSp.addChild(_tipDesTxt);
         _bg.width = 250;
         _bg.height = 220;
         _Line.y = 70;
         _loc1_ = 0;
         while(_loc1_ < 7)
         {
            _txtList[_loc1_] = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.tipAttack");
            _loc1_++;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_box50);
         _box50 = null;
         ObjectUtils.disposeObject(_tipIcon1);
         _tipIcon1 = null;
         ObjectUtils.disposeObject(_tipIcon2);
         _tipIcon2 = null;
         ObjectUtils.disposeObject(_tipGold);
         _tipGold = null;
         ObjectUtils.disposeObject(_skSp);
         _skSp = null;
         ObjectUtils.disposeObject(_tipDesTxt);
         _tipDesTxt = null;
         ObjectUtils.disposeObject(_tipHeroNameTxt);
         _tipHeroNameTxt = null;
         ObjectUtils.disposeObject(_tipSkillIcon);
         _tipSkillIcon = null;
         ObjectUtils.disposeObject(_tipHeroGoldTxt);
         _tipHeroGoldTxt = null;
         ObjectUtils.disposeObject(_attBox1);
         _attBox1 = null;
         ObjectUtils.disposeObject(_attBox2);
         _attBox2 = null;
         ObjectUtils.disposeObject(_btHeroIcon);
         _btHeroIcon = null;
         ObjectUtils.disposeObject(_profileBit);
         _profileBit = null;
         super.dispose();
         _txtList = null;
      }
   }
}

