#include "ISXRI.h"
#include "LGUIRIFrame.h"

LGUIFactory<LGUIRIFrame> RIFrameFactory("riframe");

LGUIRIFrame::LGUIRIFrame(const char *p_Factory, LGUIElement *p_pParent, const char *p_Name):LGUIFrame(p_Factory,p_pParent,p_Name)
{
	pText=0;
	Count=0;
}
LGUIRIFrame::~LGUIRIFrame(void)
{
}
bool LGUIRIFrame::IsTypeOf(char *TestFactory)
{
	return (!_stricmp(TestFactory,"riframe")) || LGUIFrame::IsTypeOf(TestFactory);
}
bool LGUIRIFrame::FromXML(class XMLNode *pXML, class XMLNode *pTemplate)
{
	if (!pTemplate)
		pTemplate=g_UIManager.FindTemplate(XMLHelper::GetStringAttribute(pXML,"Template"));
	if (!pTemplate)
		pTemplate=g_UIManager.FindTemplate("riframe");
	if (!LGUIFrame::FromXML(pXML,pTemplate))
		return false;

	// custom xml properties
	return true;
}

void LGUIRIFrame::OnCreate()
{
	// All children of this element are guaranteed to have been created now.
	pText = (LGUIText*)FindUsableChild("Output","text");
}

void LGUIRIFrame::Render()
{
	Count++;
	if (pText)
	{
		char Temp[256];
		sprintf_s(Temp,"This frame has been rendered %d times.",Count);
		pText->SetText(Temp);
	}

	LGUIFrame::Render();
}


