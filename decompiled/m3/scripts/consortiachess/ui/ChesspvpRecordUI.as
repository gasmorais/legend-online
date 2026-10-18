package consortiachess.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.chesspvp.ChesspvpRecordInfo;
   
   public class ChesspvpRecordUI extends Sprite
   {
      
      protected var _bg:ScaleBitmapImage;
      
      protected var _rdCnamebg1:ScaleBitmapImage;
      
      protected var _rdCnamebg2:ScaleBitmapImage;
      
      protected var _rdStateBg:ScaleFrameImage;
      
      protected var _rdTimeTxt:FilterFrameText;
      
      protected var _winStateTxt:FilterFrameText;
      
      protected var _rdCname1:FilterFrameText;
      
      protected var _rdCname2:FilterFrameText;
      
      protected var _rdCScore1:GradientText;
      
      protected var _rdCScore2:GradientText;
      
      protected var _rdVs:Image;
      
      private var _data:ChesspvpRecordInfo;
      
      public function ChesspvpRecordUI()
      {
         super();
         initView();
      }
      
      public function set data(param1:ChesspvpRecordInfo) : void
      {
         _data = param1;
         if(_data)
         {
            _rdTimeTxt.text = _data.recordDate;
            _rdCname1.text = _data.name;
            _rdCname2.text = _data.rivalName;
            _rdCScore1.text = "" + _data.addScore;
            _rdCScore2.text = "" + _data.rivalAddScore;
            switch(int(_data.result))
            {
               case 0:
                  _rdStateBg.setFrame(2);
                  _winStateTxt.setFrame(2);
                  break;
               case 1:
                  _rdStateBg.setFrame(1);
                  _winStateTxt.setFrame(1);
                  break;
               case 2:
                  _rdStateBg.setFrame(3);
                  _winStateTxt.setFrame(3);
            }
            _winStateTxt.text = LanguageMgr.GetTranslation("chesspvp.recored.result" + _data.result);
         }
      }
      
      protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rdKuang");
         _rdCnamebg1 = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rdCnamebg1");
         _rdCnamebg2 = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rdCnamebg2");
         _rdStateBg = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rdStateBg");
         _rdTimeTxt = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rdTimeTxt");
         _winStateTxt = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.winStateTxt");
         _rdCname1 = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rdCname1");
         _rdCname2 = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rdCname2");
         _rdCScore1 = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rdCScore1Gtx");
         _rdCScore2 = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rdCScore2Gtx");
         _rdVs = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rdVs");
         addChild(_bg);
         addChild(_rdCnamebg1);
         addChild(_rdCnamebg2);
         addChild(_rdStateBg);
         addChild(_rdTimeTxt);
         addChild(_winStateTxt);
         addChild(_rdCname1);
         addChild(_rdCname2);
         addChild(_rdCScore1);
         addChild(_rdCScore2);
         addChild(_rdVs);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_rdCnamebg1);
         _rdCnamebg1 = null;
         ObjectUtils.disposeObject(_rdCnamebg2);
         _rdCnamebg2 = null;
         ObjectUtils.disposeObject(_rdStateBg);
         _rdStateBg = null;
         ObjectUtils.disposeObject(_rdTimeTxt);
         _rdTimeTxt = null;
         ObjectUtils.disposeObject(_winStateTxt);
         _winStateTxt = null;
         ObjectUtils.disposeObject(_rdCname1);
         _rdCname1 = null;
         ObjectUtils.disposeObject(_rdCname2);
         _rdCname2 = null;
         ObjectUtils.disposeObject(_rdCScore1);
         _rdCScore1 = null;
         ObjectUtils.disposeObject(_rdCScore2);
         _rdCScore2 = null;
         ObjectUtils.disposeObject(_rdVs);
         _rdVs = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
      }
   }
}

